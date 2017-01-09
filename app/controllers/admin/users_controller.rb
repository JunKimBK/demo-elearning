class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin, only: :destroy

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.user.page.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_deleted"
    else
      flash[:danger] = t "user_not_deleted"
    end
    redirect_to admin_users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :email
  end

  def verify_admin
    @user = User.find_by_id params[:id]
    unless current_user.is_admin?
      flash[:danger] = t "access_denied"
      redirect_to root_url
    end
  end
end
