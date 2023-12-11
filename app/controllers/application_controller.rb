class ApplicationController < ActionController::Base
  private

  def after_sign_out_path_for(resource_or_scope)
    dotfiles_path
  end

  def after_sign_in_path_for(resource_or_scope)
    dotfiles_path
  end
end
