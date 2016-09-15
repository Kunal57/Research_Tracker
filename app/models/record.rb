class Record < ActiveRecord::Base
  belongs_to :student
  belongs_to :project

  validates_presence_of :student_id, :project_id
end
