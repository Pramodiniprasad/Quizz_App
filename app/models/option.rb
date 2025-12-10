class Option < ApplicationRecord
  belongs_to :question
validates :text, presence: true
# `correct` boolean marks correct option(s)
end
