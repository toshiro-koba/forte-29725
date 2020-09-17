class Gift < ApplicationRecord
  belongs_to :user
  belongs_to :giver, class_name: 'User'

  attr_accessor :token

  validates :user_id, presence: true
  validates :giver_id, presence: true
  validates :price, presence: true
  validates :token, presence: true
end
