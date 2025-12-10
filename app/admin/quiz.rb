ActiveAdmin.register Quizze do
  permit_params :title, :description, questions_attributes:
  [:id, :prompt, :question_type, :_destroy, options_attributes:
  [:id, :text, :correct, :_destroy]]
    form do |f|
      f.inputs 'Quiz' do
      f.input :title
      f.input :description
    end
    f.has_many :questions, allow_destroy: true, new_record: 'Add Question' do |qf|
      qf.input :prompt
      qf.input :question_type, as: :select, collection:
      Question.question_types.keys
      qf.has_many :options, allow_destroy: true, new_record: 'Add Option' do |
      of|
      of.input :text
      of.input :correct
    end
  end
  f.actions
  end
end
