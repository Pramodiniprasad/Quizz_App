module Api
  class AttemptsController < ApplicationController
    def create
      quiz = Quizze.find(params[:quiz_id])
      attempt = Attempt.create!(quizze: quiz, taker_name: params[:taker_name])

      answers = params[:answers] || []
      score = 0
      incorrect = []

      answers.each do |a|
        q = Question.find_by(id: a[:question_id])
        next unless q

        aa = attempt.attempt_answers.build(question: q)

        case q.question_type.to_s
        when 'mcq', 'true_false'
          if a[:option_id].present?
            opt = q.options.find_by(id: a[:option_id])
            aa.option = opt
            aa.correct = opt.present? && opt.correct?
          else
            aa.correct = false
          end
        when 'text'
          text = a[:text_answer].to_s.strip
          aa.text_answer = text
          accepted = q.options.where(correct: true).pluck(:text)
          aa.correct = accepted.any? { |acc| acc.to_s.strip.casecmp(text) == 0 }
        else
          aa.correct = false
        end

        aa.save!

        if aa.correct
          score += 1
        else
          correct_answers = if q.question_type.to_s == 'text'
                              q.options.where(correct: true).pluck(:text)
                            else
                              q.options.where(correct: true).pluck(:id, :text).map { |id, txt| { id: id, text: txt } }
                            end

          your_answer = if aa.option.present?
                         { id: aa.option.id, text: aa.option.text }
                       else
                         aa.text_answer
                       end

          incorrect << {
            question_id: q.id,
            prompt: q.prompt,
            your_answer: your_answer,
            correct_answers: correct_answers
          }
        end
      end

      attempt.update!(score: score)

      render json: {
        attempt_id: attempt.id,
        quiz_id: quiz.id,
        score: score,
        total_questions: quiz.questions.count,
        incorrect: incorrect
      }, status: :created
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Quiz not found" }, status: :not_found
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def show
      attempt = Attempt.includes(attempt_answers: [:question, :option]).find(params[:id])
      render json: attempt.as_json(only: [:id, :quiz_id, :taker_name, :score, :created_at], include: { attempt_answers: { only: [:id, :question_id, :option_id, :text_answer, :correct] } })
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Attempt not found" }, status: :not_found
    end
  end
end
