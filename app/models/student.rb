class Student < ActiveRecord::Base
  has_many :records
  has_many :projects, through: :records
  # belongs_to :project, inverse_of: :assigned_students

  validates :name, :email, { presence: true }
  validates :email, { uniqueness: true }

  has_secure_password

  def total_hours_worked
  	sum = 0 
  	self.records.each do |record|
  		sum += record.hours_worked
  	end
  	sum 
  end

  def hours_per_project(project_id)
    records = Record.where(project_id: project_id, student_id: self.id)
    sum = 0 
    records.each do |record|
      sum += record.hours_worked
    end
    sum
  end

  def working_on(project)
    zero_records = project.records.where(hours_worked: 0)

    zero_records.where(student_id: self.id).any?
  end
end
