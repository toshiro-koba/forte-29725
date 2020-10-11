class Gift < ApplicationRecord
  belongs_to :user
  belongs_to :giver, class_name: 'User'

  attr_accessor :token

  validates :user_id, presence: true
  validates :giver_id, presence: true
  validates :price, presence: true
  validates :token, presence: true

  validates :price, numericality: { greater_than_or_equal_to: 300, message: 'Out of setting range', less_than_or_equal_to: 9_999_999 }

  validates :price, numericality: { only_integer: true, message: 'Half-width number' }
end
