class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:index, :show]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.user.page.per_page
  end

  def show
    @activities_feed = @user.activities.recent.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      # flash[:success] = t "welcome"
      # redirect_to @user
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "success"
      redirect_to @user
    else
      render :edit
    end
  end

  def following
    @title = t "following"
    @user  = User.find params[:id]
    @users = @user.following.paginate page: params[:page]
    render "show_follow"
  end

  def followers
    @title = t "followers"
    @user  = User.find params[:id]
    @users = @user.followers.paginate page: params[:page]
    render "show_follow"
  end

  private
  def set_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "not_exist"
      redirect_to signup_path
    end
  end

  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_confirmation
  end

  def correct_user
    set_user
    unless @user == current_user
      flash[:alert] = t"not_current_user"
      redirect_to root_path
    end
  end
end
