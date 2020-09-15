class Room < ApplicationRecord
  has_many :entries
  has_many :users, through: :entries
end
