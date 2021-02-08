class Family < ApplicationRecord
  has_many :users
  has_many :events
  has_many :memories
  validates :name, presence: true
  validates :family_id, presence: true, uniqueness: true
end
