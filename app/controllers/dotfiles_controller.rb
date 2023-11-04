class DotfilesController < ApplicationController
  include Pagy::Backend

  before_action :set_dotfile, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /dotfiles or /dotfiles.json
  def index
    search_params = params.permit(:format, :page, q: [:title_or_description_or_config_type_or_user_username_cont])
    @q = Dotfile.ransack(search_params[:q])
    dotfiles = @q.result(distinct: true).order(created_at: :asc)
    @pagy, @dotfiles = pagy_countless(dotfiles, items: 2)
  end

  # GET /dotfiles/1 or /dotfiles/1.json
  def show
  end

  # GET /dotfiles/new
  def new
    @dotfile = current_user.dotfiles.build
  end

  # GET /dotfiles/1/edit
  def edit
  end

  # POST /dotfiles or /dotfiles.json
  def create
    @dotfile = current_user.dotfiles.build(dotfile_params)

    respond_to do |format|
      if @dotfile.save
        format.html { redirect_to dotfile_url(@dotfile), notice: "Dotfile was successfully created." }
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
        format.html { redirect_to dotfile_url(@dotfile), notice: "Dotfile was successfully updated." }
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
      format.html { redirect_to dotfiles_url, notice: "Dotfile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @dotfile = current_user.dotfiles.find_by(id: params[:id])
    redirect_to dotfiles_path, notice: "Not Authorized To Edit This Friend" if @dotfile.nil?
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
