class PagesController < ApplicationController
  before_action :authenticate_user!, only: :home

  def home
    @counters = current_user.counters
  end

  def about
  end
end
