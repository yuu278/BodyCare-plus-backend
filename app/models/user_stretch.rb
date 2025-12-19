class UserStretch < ApplicationRecord
  belongs_to :user
  belongs_to :stretch

  validates :user_id, uniqueness: { scope: :stretch_id }

  # ストレッチを完了としてマークするメソッド
  def mark_as_completed
    self.completed_count = 0 if self.completed_count.nil?
    self.completed_count += 1
    self.last_completed_at = Time.current
    save
  end
end
