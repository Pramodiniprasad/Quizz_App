class AttemptAnswer < ApplicationRecord
  belongs_to :attempt
belongs_to :question
belongs_to :option, optional: true # optional for text answers
# fields: text_answer (for text questions), option_id for MCQ/TF

end
