class Attempt < ApplicationRecord

  belongs_to :quizze, class_name: 'Quizze', foreign_key: 'quiz_id', inverse_of: :attempts
  has_many :attempt_answers, dependent: :destroy
  accepts_nested_attributes_for :attempt_answers
end
