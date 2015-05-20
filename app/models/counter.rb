# Counter
class Counter < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :palette

  # Validation
  validate :palette, presence: true

  # Callbacks
  before_save :set_name
  before_update :set_creation_date

  attr_accessor :created_at_date, :created_at_time

  # returns the non-nil value
  def clean_value
    return 0 if value.blank?
    value
  end

  # returns an array of editable attributes
  def editable_attributes
    %w(name value)
  end

  # increments the value by 1
  def increment
    update_column(:value, clean_value + 1)
  end

  private

  # sets name to 'TODO' if no name speified
  def set_name
    update_attribute(:name, 'TODO') unless name
  end

  # sets creation date
  def set_creation_date
    return unless created_at_date && created_at_time
    self.created_at = Time.zone.parse("#{created_at_date} #{created_at_time}")
  end
end
