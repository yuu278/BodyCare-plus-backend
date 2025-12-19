require 'rails_helper'

RSpec.describe Stretch, type: :model do
  describe 'バリデーション' do
    it 'name, description, target_area があれば有効であること' do
      stretch = build(:stretch)
      expect(stretch).to be_valid
    end

    it 'name がない場合は無効であること' do
      stretch = build(:stretch, name: nil)
      expect(stretch).not_to be_valid
    end

    it 'description がない場合は無効であること' do
      stretch = build(:stretch, description: nil)
      expect(stretch).not_to be_valid
    end

    it 'target_area がない場合は無効であること' do
      stretch = build(:stretch, target_area: nil)
      expect(stretch).not_to be_valid
    end
  end

  describe '.matching' do
    let!(:stretch1) { create(:stretch, body_part: 'neck', pain_type: ['痛み'], job_type: ['sitting_work']) }
    let!(:stretch2) { create(:stretch, body_part: 'waist', pain_type: ['重だるさ'], job_type: ['standing_work']) }

    let(:assessment) do
      double(
        pain_area: 'neck',
        pain_types: ['痛み'],
        duration: ['1ヶ月未満'],
        job_types: ['sitting_work'],
        exercise_habits: ['some_exercise'],
        posture_habits: ['hunched_shoulders']
      )
    end

    context '条件が一致する場合' do
      it '該当するストレッチを返すこと' do
        result = Stretch.matching(assessment)
        expect(result).to include(stretch1)
        expect(result).not_to include(stretch2)
      end
    end

    context '条件が一部異なる場合' do
      it 'body_part が異なると含まれないこと' do
        wrong_assessment = double(
          pain_area: 'waist',
          pain_types: ['痛み'],
          duration: ['1ヶ月未満'],
          job_types: ['sitting_work'],
          exercise_habits: ['some_exercise'],
          posture_habits: ['hunched_shoulders']
        )
        result = Stretch.matching(wrong_assessment)
        expect(result).not_to include(stretch1)
      end

      it 'pain_type が異なると含まれないこと' do
        wrong_assessment = double(
          pain_area: 'neck',
          pain_types: ['痺れ'],
          duration: ['1ヶ月未満'],
          job_types: ['sitting_work'],
          exercise_habits: ['some_exercise'],
          posture_habits: ['hunched_shoulders']
        )
        result = Stretch.matching(wrong_assessment)
        expect(result).not_to include(stretch1)
      end
    end
  end

  describe '.flexible_matching' do
    let!(:perfect_match) do
      create(:stretch,
        body_part: 'neck',
        pain_type: ['痛み'],
        duration: ['1ヶ月未満'],
        job_type: ['sitting_work'],
        exercise_habit: ['some_exercise'],
        posture_habit: ['hunched_shoulders']
      )
    end

    let!(:similar_match) do
      create(:stretch,
        body_part: 'neck',
        pain_type: ['痛み'],
        duration: ['数日以内'], # duration違い
        job_type: ['sitting_work'],
        exercise_habit: ['some_exercise'],
        posture_habit: ['hunched_shoulders']
      )
    end

    let!(:partial_match) do
      create(:stretch,
        body_part: 'neck',
        pain_type: ['痛み'],
        duration: ['1ヶ月未満'],
        job_type: ['standing_work'], # job_type違い
        exercise_habit: ['regular_exercise'], # exercise_habit違い
        posture_habit: ['hunched_shoulders']
      )
    end

    let!(:pain_only_match) do
      create(:stretch,
        body_part: 'neck',
        pain_type: ['痛み'],
        duration: ['1ヶ月以上'],
        job_type: ['standing_work'],
        exercise_habit: ['regular_exercise'],
        posture_habit: ['straight_back'] # posture違い
      )
    end

    let(:assessment) do
      double(
        pain_area: 'neck',
        pain_types: ['痛み'],
        duration: ['1ヶ月未満'],
        job_types: ['sitting_work'],
        exercise_habits: ['some_exercise'],
        posture_habits: ['hunched_shoulders']
      )
    end

    context '1段階目: すべての条件が一致する場合' do
      it '完全一致したストレッチを返す' do
        result = Stretch.flexible_matching(assessment)
        expect(result).to contain_exactly(perfect_match)
      end
    end

    context '2段階目: durationを無視する場合' do
      it 'duration以外が一致すれば結果を返す' do
        wrong_assessment = double(
          pain_area: 'neck',
          pain_types: ['痛み'],
          duration: ['数日以内'], # 不一致
          job_types: ['sitting_work'],
          exercise_habits: ['some_exercise'],
          posture_habits: ['hunched_shoulders']
        )
        result = Stretch.flexible_matching(wrong_assessment)
        expect(result).to include(similar_match)
      end
    end

    context '3段階目: duration + exercise_habitを無視する場合' do
      it 'それらが不一致でも該当を返す' do
        wrong_assessment = double(
          pain_area: 'neck',
          pain_types: ['痛み'],
          duration: ['1ヶ月未満'],
          job_types: ['standing_work'], # job_type違い
          exercise_habits: ['regular_exercise'], # exercise_habit違い
          posture_habits: ['hunched_shoulders']
        )
        result = Stretch.flexible_matching(wrong_assessment)
        expect(result).to include(partial_match)
      end
    end

    context '4段階目: duration + job_type + exercise_habitを無視する場合' do
      it 'pain_typeとposture_habitが一致すれば返す' do
        wrong_assessment = double(
          pain_area: 'neck',
          pain_types: ['痛み'],
          duration: ['存在しない値'], # どのstretchにも一致しない値
          job_types: ['存在しない値'],
          exercise_habits: ['存在しない値'],
          posture_habits: ['hunched_shoulders'] # 一致条件
        )
        result = Stretch.flexible_matching(wrong_assessment)
        expect(result.pluck(:id)).to include(perfect_match.id, similar_match.id, partial_match.id)
      end
    end

    context '5段階目: pain_type のみ一致する場合' do
      it 'pain_typeのみ一致するストレッチを返す' do
        wrong_assessment = double(
          pain_area: 'neck',
          pain_types: ['痛み'],
          duration: ['1ヶ月未満'],
          job_types: ['both'],
          exercise_habits: ['no_exercise'],
          posture_habits: ['straight_back'] # 全く異なる
        )
        result = Stretch.flexible_matching(wrong_assessment)
        expect(result).to include(pain_only_match)
      end
    end
  end
end