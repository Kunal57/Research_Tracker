class Project < ActiveRecord::Base
  belongs_to :professor
  has_many :records
  has_many :students, through: :records

end
