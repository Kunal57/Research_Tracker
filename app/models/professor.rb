class Professor < ActiveRecord::Base
  has_many :projects
  has_many :students, through: :projects

  validates :name, :email, { presence: true }
  validates :email, { uniqueness: true }

  has_secure_password

  def pending_projects
  	Projects.where(status: "pending")
  end

  def active_projects
  	Projects.where(status: "active")
  end

  def completed_projects
  	Projects.where(status: "complete")
  end
end
