class Professor < ActiveRecord::Base
  has_many :projects
  has_many :students, through: :projects

  validates :name, :email, { presence: true }
  validates :email, { uniqueness: true }

  has_secure_password


  def self.pending_profs
    Professor.where(is_approved: false)
  end

  def pending_projects
  	self.projects.where(status: "pending")
  end

  def active_projects
  	self.projects.where(status: "active")
  end

  def completed_projects
  	self.projects.where(status: "complete")
  end

	def rejected_projects
  	self.projects.where(status: "rejected")
  end

end
