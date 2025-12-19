require 'rails_helper'

RSpec.describe UserStretch, type: :model do
  describe 'バリデーション' do
    it 'user_id と stretch_id の組み合わせが一意であること' do
      user = create(:user)
      stretch = create(:stretch)
      create(:user_stretch, user: user, stretch: stretch)

      duplicate = build(:user_stretch, user: user, stretch: stretch)
      expect(duplicate).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    it 'user に属していること' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'stretch に属していること' do
      association = described_class.reflect_on_association(:stretch)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe '#mark_as_completed' do
    it 'completed_count が増加し、last_completed_at が更新されること' do
      user_stretch = create(:user_stretch, completed_count: 0, last_completed_at: nil)

      user_stretch.mark_as_completed

      expect(user_stretch.completed_count).to eq 1
      expect(user_stretch.last_completed_at).not_to be_nil
    end

    it 'completed_count が nil の場合は 0 として扱われること' do
      user_stretch = create(:user_stretch, completed_count: nil)

      user_stretch.mark_as_completed

      expect(user_stretch.completed_count).to eq 1
    end
  end
end