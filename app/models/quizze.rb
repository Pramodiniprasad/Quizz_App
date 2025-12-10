class Quizze < ApplicationRecord
  has_many :questions, dependent: :destroy, foreign_key: 'quiz_id', inverse_of: :quizze
  has_many :attempts, class_name: 'Attempt', foreign_key: 'quiz_id', inverse_of: :quizze, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true
  validates :title, presence: true

   def self.ransackable_associations(auth_object = nil)
    ["questions"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["title", "description", "created_at", "updated_at"]
  end

end
