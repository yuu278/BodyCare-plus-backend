require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '有効なユーザーが作成できること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'name がない場合は無効であること' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'email がない場合は無効であること' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'password がない場合は無効であること' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    it 'body_assessments を複数持てること' do
      association = described_class.reflect_on_association(:body_assessments)
      expect(association.macro).to eq :has_many
    end

    it 'user_stretches を複数持てること' do
      association = described_class.reflect_on_association(:user_stretches)
      expect(association.macro).to eq :has_many
    end

    it 'stretches を user_stretches を通して複数持てること' do
      association = described_class.reflect_on_association(:stretches)
      expect(association.macro).to eq :has_many
    end
  end
end
