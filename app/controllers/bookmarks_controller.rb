# frozen_string_literal: true

# Controller for bookmarks logic
class BookmarksController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def index
    search_params = params.permit(:format, :page, :commit, :locale,
                                  q: %i[title_or_description_or_config_type_or_user_username_cont config_type_eq s])
    @q = Dotfile.ransack(search_params[:q])
    order_by = get_order_(search_params)
    dotfiles = @q.result(distinct: true).order(order_by => :desc)
    @bookmarks_pagy, @bookmarks = pagy(dotfiles, items: 10)
  rescue Pagy::OverflowError
    redirect_to bookmarks_index_path(page: 1)
  end

  private

  def get_order_(search_params)
    if !search_params[:q].nil? && !search_params[:q][:s].nil?
      order_by = search_params[:q][:s].split[0]
      order_by = (order_by == 'created_at' ? :created_at : :cached_weighted_like_score)
    else
      order_by = :cached_weighted_like_score
    end
    order_by
  end
end
