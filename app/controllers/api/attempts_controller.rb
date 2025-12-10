# app/controllers/api/attempts_controller.rb
module Api
  class AttemptsController < ApplicationController
    protect_from_forgery with: :null_session
      def create
        quiz = Quiz.find(attempt_params[:quiz_id])
        attempt = quiz.attempts.create(taker_name: attempt_params[:taker_name])
        score = 0
        attempt_params[:answers].each do |ans|
          q = Question.find(ans[:question_id])
            if q.mcq? || q.true_false?
            selected_option = q.options.find_by(id: ans[:option_id])
            correct = selected_option&.correct
            attempt.attempt_answers.create(question: q, option: selected_option,
            correct: !!correct)
            score += 1 if correct
            else
            attempt.attempt_answers.create(question: q, text_answer:
            ans[:text_answer], correct: nil)
          end
        end
        attempt.update(score: score)
        render json: { attempt_id: attempt.id, score: score }
      end

      def show
        attempt = Attempt.includes(attempt_answers:
        [:question, :option]).find(params[:id])
        render json: attempt.as_json(include: { attempt_answers: { include:
        [:question, :option] } })
      end
      
      private
      
      def attempt_params
        params.require(:attempt).permit(:quiz_id, :taker_name, answers:[:question_id, :option_id, :text_answer])
      end
  end
end