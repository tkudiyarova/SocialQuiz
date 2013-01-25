class QuestionsController < ApplicationController
  before_filter :signed_in_user,  only: [:create, :destroy]
  before_filter :correct_user,    only: :destroy

  def create
  	@question = current_user.questions.build(params[:question])
    if @question.save
      flash[:success] = "question created!"
      redirect_to root_url
    else
      render 'pages/home'
    end
  end

  def destroy
    @question.destroy
    redirect_to root_url
  end

  private
  def correct_user
    @question = current_user.questions.find_by_id(params[:id])
    redirect_to root_url if @question.nil?
  end
end