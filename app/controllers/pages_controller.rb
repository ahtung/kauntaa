class PagesController < ApplicationController
  before_action :authenticate_user!, only: :home

  def home
    @counter = current_user.counter
  end

  def about
  end
end
