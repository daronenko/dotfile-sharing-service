class DotfilesController < ApplicationController
  before_action :set_dotfile, only: %i[ show edit update destroy ]

  # GET /dotfiles or /dotfiles.json
  def index
    @dotfiles = Dotfile.all
  end

  # GET /dotfiles/1 or /dotfiles/1.json
  def show
  end

  # GET /dotfiles/new
  def new
    @dotfile = Dotfile.new
  end

  # GET /dotfiles/1/edit
  def edit
  end

  # POST /dotfiles or /dotfiles.json
  def create
    @dotfile = Dotfile.new(dotfile_params)

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dotfile
      @dotfile = Dotfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dotfile_params
      params.require(:dotfile).permit(:title, :description, :config_type, :file)
    end
end
