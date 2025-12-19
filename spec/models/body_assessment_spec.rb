require 'rails_helper'

RSpec.describe BodyAssessment, type: :model do
  describe 'バリデーション' do
    it '必須項目がすべて揃っていれば有効であること' do
      assessment = build(:body_assessment)
      expect(assessment).to be_valid
    end

    it 'pain_area がない場合は無効であること' do
      assessment = build(:body_assessment, pain_area: nil)
      expect(assessment).not_to be_valid
    end

    it 'pain_types がない場合は無効であること' do
      assessment = build(:body_assessment, pain_types: nil)
      expect(assessment).not_to be_valid
    end

    it 'duration がない場合は無効であること' do
      assessment = build(:body_assessment, duration: nil)
      expect(assessment).not_to be_valid
    end

    it 'job_types がない場合は無効であること' do
      assessment = build(:body_assessment, job_types: nil)
      expect(assessment).not_to be_valid
    end

    it 'exercise_habits がない場合は無効であること' do
      assessment = build(:body_assessment, exercise_habits: nil)
      expect(assessment).not_to be_valid
    end

    it 'posture_habits がない場合は無効であること' do
      assessment = build(:body_assessment, posture_habits: nil)
      expect(assessment).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    it 'user に属していること' do
      association = BodyAssessment.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
