class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @counter = current_user.counter
  end

  def about
  end
end
