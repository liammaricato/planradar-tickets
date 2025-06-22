class User < ApplicationRecord
  has_many :tickets, dependent: :destroy
  
  validates :name, presence: true
  validates :mail, presence: true
end
