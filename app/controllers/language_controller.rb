class LanguageController < ApplicationController

  SUPPORTED_LANGUAGES = %w(en es nl tr de fr)

  def select_language
    if SUPPORTED_LANGUAGES.include? params[:language_code]
      session[:current_language] = params[:language_code]
      redirect_to request.referer + "#googtrans(nl|#{params[:language_code]})"
    end
  end

end