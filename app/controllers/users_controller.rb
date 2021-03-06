class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :new_user, only: [:new, :create]

  def show
  	@user = User.find(params[:id])
    @questions = @user.questions.paginate(page: params[:page])
  end
  
  def new
  	@user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      signin @user
    	flash[:success] = "Welcome to the Social Quiz!"
    	redirect_to @user
    else
    	render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      signin @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def new_user
    if signed_in?
      redirect_to(root_path)
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def check_email
    @user = User.find_by_email(params[:user][:eamil])
    respond_to do |format|
      format.json { render :json => !@user }
    end
  end
end
