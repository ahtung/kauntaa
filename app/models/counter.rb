class Counter < ActiveRecord::Base
  belongs_to :user

  def clean_value
    if value
      value
    else
      0
    end
  end
end
