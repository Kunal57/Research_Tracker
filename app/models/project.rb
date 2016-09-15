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

end
