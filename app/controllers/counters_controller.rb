# CountersController
class CountersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_counter, only: [:show, :edit, :update, :increment, :decrement, :destroy]
  before_action :set_palette_if_counter
  after_action :verify_authorized, except: :show
  after_action :allow_iframe, only: :show

  def show
    render layout: false
  end

  def index
    authorize Counter, :index?
    @counters = current_user.counters.order(updated_at: :desc)
  end

  def new
    @palette = Palette.find(params[:palette_id])
    @counter = current_user.counters.new(palette: @palette)
    authorize @counter
    render layout: false
  end

  def new_counter
    @counter = current_user.counters.new
    authorize @counter, :new?
    render layout: false
  end

  def edit
    authorize @counter
    render layout: false
  end

  def update
    authorize @counter
    if @counter.update_attributes(counter_params)
      redirect_to user_root_path, notice: 'Counter updated.'
    else
      redirect_to user_root_path, alert: 'Unable to update counter.'
    end
  end

  def destroy
    authorize @counter
    if @counter.destroy
      redirect_to user_root_path, notice: 'Counter deleted.'
    else
      redirect_to user_root_path, alert: 'Unable to delete counter.'
    end
  end

  def increment
    authorize @counter, :update?
    @counter.update_attribute(:value, @counter.clean_value + 1)
    render layout: false
  end

  def decrement
    authorize @counter, :update?
    @counter.update_attribute(:value, @counter.clean_value - 1)
    render layout: false
  end

  private

  def set_counter
    @counter = Counter.find(params[:id])
  end

  def set_palette_if_counter
    @palette = @counter.palette if @counter && @counter.palette
  end

  def counter_params
    params.require(:counter).permit(:id, :name, :value, :created_at_date, :created_at_time, :palette_id)
  end
end
