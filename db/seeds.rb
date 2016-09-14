# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Professor.create(name: "admin", email: "admin@admin.com", password: "password", is_approved: true, is_admin: true)

Professor.create(name: "Matt Baker", email: "matt@madzcintiztz.com", password: "password")

Student.create(name: "Duke", email: "duke@duke.com", password: "password")

Project.create(title: "Mad Zcienz", hypothesis: "cool shit will happen", summary: "do experiments, yo", time_budget: 400, professor_id: 2)

Record.create(student_id: 1, project_id: 1)



