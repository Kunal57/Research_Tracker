class Project < ActiveRecord::Base
  belongs_to :professor
  has_many :records
  has_many :students, through: :records


  def self.pending_projects
    Project.where(status: 'pending')
  end

  def current?
  	self.status == "active"
  end

  def complete?
  	self.status == "complete"
  end

  def remaining_time
  	total_worked = 0
  	self.records.each do |record|
  		total_worked += record.hours_worked
  	end
  	self.time_budget - total_worked
  end

end
