class CountersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_counter, only: [:edit, :update, :increment]

  def edit
  end

  def update
    respond_to do |format|
      if @counter.update(counter_params)
        format.html { redirect_to root_path, notice: 'Counter was successfully updated.' }
        format.json { render :show, status: :ok, location: @counter }
      else
        format.html { render :edit }
        format.json { render json: @counter.errors, status: :unprocessable_entity }
      end
    end
  end

  def increment
    @counter.update_attribute(:value, @counter.clean_value + 1)
    render layout: false
  end

  private

  def set_counter
    @counter = current_user.counter
  end

  def counter_params
    params.require(:counter).permit(:name, :value)
  end

end