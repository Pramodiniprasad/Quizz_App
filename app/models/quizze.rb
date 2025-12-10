class Quizze < ApplicationRecord
    # A quiz has many questions
  has_many :questions, dependent: :destroy
  # Accept nested attributes so admin can create questions when creating a quiz
  accepts_nested_attributes_for :questions, allow_destroy: true
  validates :title, presence: true

   def self.ransackable_associations(auth_object = nil)
    ["questions"]
  end

  # Allow searchable fields for ActiveAdmin
  def self.ransackable_attributes(auth_object = nil)
    ["title", "description", "created_at", "updated_at"]
  end

end
