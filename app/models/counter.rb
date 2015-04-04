# Counter
class Counter < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :palette

  # Callbacks
  before_save :set_name
  before_save :set_palette
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

  private

  # sets a random palette
  def set_palette
    self.palette = Palette.all.sample
  end

  # sets name to 'TODO' if no name speified
  def set_name
    update_attribute(:name, 'TODO') unless name
  end

  # sets creation date
  def set_creation_date
    if created_at_date && created_at_time
      self.created_at = DateTime.parse("#{created_at_date} #{created_at_time}")
    end
  end
end
