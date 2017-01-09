class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.search_name(params[:q]).alphabetically
      .paginate page: params[:page], per_page: Settings.user.page.per_page
  end
end
