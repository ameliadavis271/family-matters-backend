class User < ApplicationRecord
  has_secure_password
  belongs_to :family
  validates :email, presence: true, uniqueness: true
  validates :family_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
