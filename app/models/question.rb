class Question < ApplicationRecord
  belongs_to :quizze, class_name: 'Quizze', foreign_key: 'quiz_id', inverse_of: :questions
  has_many :options, dependent: :destroy

  accepts_nested_attributes_for :options, allow_destroy: true

  enum :question_type, {mcq: 0, true_false: 1, text: 2 }

  validates :prompt, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "prompt", "question_type", "quiz_id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["quiz", "options"]
  end
end
