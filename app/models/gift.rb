class Gift < ApplicationRecord
  belongs_to :user
  belongs_to :giver, class_name: 'User'

  attr_accessor :token

  validates :user_id, presence: true
  validates :giver_id, presence: true
  validates :price, presence: true
  validates :token, presence: true

  validates :price, numericality: { greater_than_or_equal_to: 300, message: 'が範囲外です', less_than_or_equal_to: 50_000 }

  validates :price, numericality: { only_integer: true, message: 'は半角数字で入力してください' }
end
