class Student < ActiveRecord::Base
  has_many :records
  has_many :projects, through: :records

  validates :name, :email, { presence: true }
  validates :email, { uniqueness: true }

  has_secure_password
end
