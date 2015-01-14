class Counter < ActiveRecord::Base
  belongs_to :user

  before_save :set_name

  def clean_value
    if value
      value
    else
      0
    end
  end

  private

  def set_name
    update_attribute(:name, 'TODO') unless name
  end
end
