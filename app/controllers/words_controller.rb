class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.all
    if params[:filter_state]
      @words = Word.create_day.send(params[:filter_state],
        current_user.id).paginate page: params[:page],
        per_page: Settings.user.page.per_page
    else
      @words = Word.create_day.paginate page: params[:page],
        per_page: Settings.user.page.per_page
    end
  end
end
