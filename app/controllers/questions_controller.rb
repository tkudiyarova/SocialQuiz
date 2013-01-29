class QuestionsController < ApplicationController
  before_filter :signed_in_user,  only: [:new, :create, :destroy]
  before_filter :correct_user,    only: :destroy

  def new
    @question = current_user.questions.build if signed_in?
  end

  def create
  	@question = current_user.questions.build(params[:question])
    if @question.save
      flash[:success] = "question created!"
      redirect_to @question
    else
      render 'new'
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def destroy
    @question.destroy
    redirect_to current_user
  end

  private
  def correct_user
    @question = current_user.questions.find_by_id(params[:id])
    redirect_to root_url if @question.nil?
  end
end