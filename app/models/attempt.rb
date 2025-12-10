class Attempt < ApplicationRecord
  belongs_to :quizze
has_many :attempt_answers, dependent: :destroy
accepts_nested_attributes_for :attempt_answers
# store taker's name or session data if anonymous
end
