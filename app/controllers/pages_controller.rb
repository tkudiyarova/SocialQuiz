class PagesController < ApplicationController
  def home
  	@question = current_user.questions.build if signed_in?
  end

  def about
  end
end
