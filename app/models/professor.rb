class Professor < ActiveRecord::Base
  has_many :projects
  has_many :students, through: :projects

  has_secure_password
end
