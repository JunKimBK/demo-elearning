class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = Activity.user_activities(current_user).recent
        .paginate page: params[:page]
    end
  end
end
