class BookmarksController < ApplicationController
  include Pagy::Backend
  
  before_action :authenticate_user!

  def index
    search_params = params.permit(:format, :page, q: [:title_or_description_or_config_type_or_user_username_cont, :config_type_eq])
    @q = Dotfile.ransack(search_params[:q])
    dotfiles = @q.result(distinct: true).order(cached_weighted_like_score: :desc)
    @bookmarks_pagy, @bookmarks = pagy(dotfiles, items: 2)
  rescue Pagy::OverflowError
    redirect_to bookmarks_index_path(page: 1)
  end
end
