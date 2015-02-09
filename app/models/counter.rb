class Counter < ActiveRecord::Base
  belongs_to :user

  before_save :set_name
  before_update :set_creation_date
  attr_accessor :created_at_date, :created_at_time

  def clean_value
    if value
      value
    else
      0
    end
  end

  def editable_attributes
    %w(name value)
  end

  private

  def set_name
    update_attribute(:name, 'TODO') unless name
  end

  def set_creation_date
    if self.created_at_date && self.created_at_time
      self.created_at = "#{self.created_at_date} #{self.created_at_time}:00".to_time
      # TODO When a timezone is defined, will use below
      # self.created_at.utc
    end
  end
end
