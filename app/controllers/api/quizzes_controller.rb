module Api
  class QuizzesController < ApplicationController
    def index
      quizzes = Quizze.all.includes(questions: :options)
      render json: quizzes.as_json(
        only: [:id, :title, :description],
        include: {
          questions: {
            only: [:id, :prompt, :question_type],
            include: {
              options: { only: [:id, :text] }
            }
          }
        }
      )
    end

    def show
      quiz = Quizze.includes(questions: :options).find(params[:id])
      render json: quiz.as_json(
        only: [:id, :title, :description],
        include: {
          questions: {
            only: [:id, :prompt, :question_type],
            include: {
              options: { only: [:id, :text] }
            }
          }
        }
      )
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Quiz not found" }, status: :not_found
    end
  end
end
