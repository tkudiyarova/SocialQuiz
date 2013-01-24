class QuestionsController < ApplicationController
  before_filter :signed_in_user

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
  end
end