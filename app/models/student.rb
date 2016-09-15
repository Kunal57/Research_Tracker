class Student < ActiveRecord::Base
  has_many :records
  has_many :projects, through: :records

  validates :name, :email, { presence: true }
  validates :email, { uniqueness: true }

  has_secure_password

  def total_hours_worked
  	sum = 0 
  	self.records.each do |record|
  		if record.hours_worked
  			sum += record.hours_worked
  		end
  	end
  	sum 
  end
end
