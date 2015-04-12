# ApplicationController
class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :set_palette

  private

  def set_palette
    @palette = Palette.all.sample
  end

  def allow_iframe
    response.headers.delete 'X-Frame-Options'
  end
end
