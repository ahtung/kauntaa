# Counter
class Counter < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :palette

  # Validation
  validates :name, :palette, presence: true

  # Callbacks
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

  # returns the increment url
  def increment_url
    Rails.application.routes.url_helpers.increment_user_counter_path(user_id: user.id, id: id)
  end

  private

  # sets creation date
  def set_creation_date
    return unless created_at_date && created_at_time
    self.created_at = Time.zone.parse("#{created_at_date} #{created_at_time}")
  end
end
