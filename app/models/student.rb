class Student < ActiveRecord::Base
  has_many :records
  has_many :projects, through: :records

  has_secure_password
end
