class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def after_sign_out_path_for(resource_or_scope)
    dotfiles_path
  end

  def after_sign_in_path_for(resource_or_scope)
    dotfiles_path
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ?
      parsed_locale.to_sym :
      nil
  end
end
