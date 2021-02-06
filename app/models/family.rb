class Family < ApplicationRecord
    validates :name, presence: true
    validates :family_id, presence: true, uniqueness: true
    has_many :users
    has_many :events
end
