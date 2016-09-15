class Professor < ActiveRecord::Base
  has_many :projects
  has_many :students, through: :projects

  validates :name, :email, { presence: true }
  validates :email, { uniqueness: true }

  has_secure_password

  def pending_profs
    Professor.where(is_approved: false)
  end
end
