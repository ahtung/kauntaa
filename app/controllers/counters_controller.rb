# CountersController
class CountersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_counter, only: [:show, :edit]
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

  def edit
    authorize @counter
    render layout: false
  end

  private

  def set_counter
    @counter = Counter.find(params[:id])
  end

  def set_palette_if_counter
    @palette = @counter.palette if @counter && @counter.palette
  end
end
