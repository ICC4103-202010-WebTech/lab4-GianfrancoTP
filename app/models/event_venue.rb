class EventVenue < ApplicationRecord
  validates :address, presence: true
  validates :capacity, numericality: {greater_than_or_equal_to: 10}
  has_many :events
end
