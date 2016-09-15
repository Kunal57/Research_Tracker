class Project < ActiveRecord::Base
  belongs_to :professor
  has_many :records
  has_many :students, through: :records


  def self.pending_projects
    Project.where(status: 'pending')
  end

end
