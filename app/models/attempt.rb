class Attempt < ApplicationRecord

  belongs_to :quizze, class_name: 'Quizze', foreign_key: 'quiz_id', inverse_of: :attempts
  has_many :attempt_answers, dependent: :destroy
  accepts_nested_attributes_for :attempt_answers

  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "quiz_id",
      "taker_name",
      "score",
      "created_at",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["attempt_answers", "quizze"]
  end
end
