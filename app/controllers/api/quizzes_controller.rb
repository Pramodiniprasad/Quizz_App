# app/controllers/api/quizzes_controller.rb
module Api
  class QuizzesController < ApplicationController
    
    def index
      quizzes = Quiz.all
      render json: quizzes.as_json(only: [:id,:title,:description])
    end

    def show
      quiz = Quiz.includes(questions: :options).find(params[:id])
      render json: quiz.as_json(include: { questions: { include: :options } })
    end
  end
end