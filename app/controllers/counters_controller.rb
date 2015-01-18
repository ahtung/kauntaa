class CountersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_counter, only: [:edit, :update, :increment, :decrement, :destroy]

  def new
    @counter = current_user.counters.new
  end

  def edit
  end

  def create
    current_user.counters.create(counter_params)
    redirect_to root_path
  end

  def update
    @counter.update(counter_params)
    redirect_to root_path
  end

  def destroy
    @counter.destroy
    redirect_to root_path
  end

  def increment
    @counter.update_attribute(:value, @counter.clean_value + 1)
    render layout: false
  end

  def decrement
    @counter.update_attribute(:value, @counter.clean_value - 1)
    render layout: false
  end

  private

  def set_counter
    @counter = Counter.find(params[:id])
  end

  def counter_params
    params.require(:counter).permit(:id, :name, :value)
  end
end
