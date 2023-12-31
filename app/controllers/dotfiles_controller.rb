# frozen_string_literal: true

# Controller for dotfiles logic
class DotfilesController < ApplicationController
  include Pagy::Backend

  before_action :set_dotfile, only: %i[show edit update destroy vote bookmark]
  before_action :authenticate_user!, except: %i[index show]
  before_action :correct_user, only: %i[edit update destroy]

  # GET /dotfiles or /dotfiles.json
  def index
    search_params = params.permit(:format, :page, :commit, :locale,
                                  q: %i[title_or_description_or_config_type_or_user_username_cont config_type_eq s])
    @q = Dotfile.ransack(search_params[:q])
    order_by = get_order_(search_params)
    dotfiles = @q.result(distinct: true).order(order_by => :desc)
    @dotfiles_pagy, @dotfiles = pagy(dotfiles, items: 2)
  rescue Pagy::OverflowError
    redirect_to dotfiles_path(page: 1)
  end

  def get_order_(search_params)
    if !search_params[:q].nil? && !search_params[:q][:s].nil?
      order_by = search_params[:q][:s].split[0]
      order_by = (order_by == 'created_at' ? :created_at : :cached_weighted_like_score)
    else
      order_by = :cached_weighted_like_score
    end
    order_by
  end

  def bookmark
    @dotfile.bookmark!(current_user)
    respond_to do |format|
      format.html do
        redirect_to @dotfile
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          @dotfile, partial: 'dotfiles/dotfile',
                    locals: { dotfile: @dotfile, show_config: params[:show_config] }
        )
      end
    end
  end

  def vote
    case params[:type]
    when 'upvote'
      @dotfile.upvote!(current_user)
    when 'downvote'
      @dotfile.downvote!(current_user)
    else
      return redirect_to request.url, alert: 'no such vote type'
    end
    respond_to do |format|
      format.html do
        redirect_to @dotfile
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@dotfile, partial: 'dotfiles/dotfile',
                                                            locals: { dotfile: @dotfile, show_config: params[:show_config] })
      end
    end
  end

  # GET /dotfiles/1 or /dotfiles/1.json
  def show; end

  # GET /dotfiles/new
  def new
    @dotfile = current_user.dotfiles.build
  end

  # GET /dotfiles/1/edit
  def edit; end

  # POST /dotfiles or /dotfiles.json
  def create
    @dotfile = current_user.dotfiles.build(dotfile_params)

    respond_to do |format|
      if @dotfile.save
        format.html { redirect_to dotfile_url(@dotfile), notice: I18n.t('notices.create_dotfile') }
        format.json { render :show, status: :created, location: @dotfile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dotfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dotfiles/1 or /dotfiles/1.json
  def update
    respond_to do |format|
      if @dotfile.update(dotfile_params)
        format.html { redirect_to dotfile_url(@dotfile), notice: I18n.t('notices.update_dotfile') }
        format.json { render :show, status: :ok, location: @dotfile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dotfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dotfiles/1 or /dotfiles/1.json
  def destroy
    @dotfile.destroy!

    respond_to do |format|
      format.html { redirect_to dotfiles_url, notice: I18n.t('notices.destroy_dotfile') }
      format.json { head :no_content }
    end
  end

  def correct_user
    @dotfile = current_user.dotfiles.find_by(id: params[:id])
    redirect_to dotfiles_path, notice: I18n.t('notices.not_authorized_to_edit') if @dotfile.nil?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dotfile
    @dotfile = Dotfile.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def dotfile_params
    params.require(:dotfile).permit(:title, :description, :config_type, :file, :user_id)
  end
end
