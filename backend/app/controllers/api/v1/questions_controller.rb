class Api::V1::QuestionsController < ApplicationController
  before_action :set_quiz

  def index
    if @quiz
      @result = Result.find_by(quiz: @quiz, user: current_user)
      if @result.present?
        redirect_to api_v1_results_path(quiz_id: @quiz.id)
      else
  		  render json: choose_questions
      end
    else
      head 400
    end
	end

  def show
    render json: @quiz.questions.find(params[:id])
  end

  private

  def choose_questions
    if @quiz
      join_sql = <<-SQL
        LEFT JOIN user_answers ON
          user_answers.question_id = questions.id AND
          user_answers.user_id = #{current_user.id}
      SQL
      not_answered = @quiz.questions.joins(join_sql).where('user_answers.id IS NULL')
      answered_count = @quiz.questions.count - not_answered.count
      not_answered.sample(10 - answered_count)
    else 
      head 400
    end
  end

  def set_quiz
    if params[:quiz_id].present?
      @quiz = Quiz.find(params[:quiz_id])
    end 
  end
end