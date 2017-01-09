class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    return notification unless @user
    current_user.follow @user
    respond
  end

  def destroy
    relationship = Relationship.find_by id: params[:id]
    return notification unless relationship
    @user = relationship.followed
    current_user.unfollow @user
    respond
  end

  private
  def notification
    flash[:alert] = t "relationship_fails"
  end

  def respond
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
