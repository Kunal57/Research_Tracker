# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Professor.create(name: "Admin Dashboard", email: "admin@admin.com", password: "password", is_approved: true, is_admin: true)

Professor.create(name: "Matt Baker", email: "matt@madzcintiztz.com", password: "password")

Student.create(name: "Duke", email: "duke@duke.com", password: "password")

Project.create(title: "Mad Zcienz", hypothesis: "cool shit will happen", summary: "do experiments, yo", time_budget: 400, professor_id: 2)
 
Record.create(student_id: 1, project_id: 1)
 
# Active Project
Project.create(title: "Why does the sun shine?", hypothesis: "The Sun is a mass of incandescent gas", summary: "a gigantic nuclear furnace", time_budget: 400, professor_id: 2, status: "active")
 
# Completed Project
Project.create(title: "SCIENCE!", hypothesis: "it's poetry in motion", summary: "She blinded me, with SCIENCE!", time_budget: 10000, professor_id: 2, status: "complete")
 
# Rejected Project
Project.create(title: "Weird Science", hypothesis: "cool shit will happen", summary: "do experiments, yo", time_budget: 400, professor_id: 2, status: "rejected")


10.times do
  Professor.create!(email: Faker::Internet.email,
               name: Faker::Name.name,
               password: "password",
               is_approved: true)
end

Professor.all.each do |professor|
    professor.projects.create!(professor_id: professor.id,
                          title: Faker::Hipster.sentence,
                          hypothesis: Faker::Lorem.sentence,
                          summary: Faker::Lorem.paragraph(20),
                          time_budget: rand(100..700),
                          status: "active")
end

30.times do
  Student.create!(email: Faker::Internet.email,
               name: Faker::Name.name,
               password: "password")
end

Student.all.each do |student|
  rand(1..10).times do
    student.records.create!(student_id: student.id,
    											project_id: rand(1..10), 
                          hours_worked: rand(10..50),
                          observations: Faker::Lorem.paragraph(2, true))
  end
end

Professor.find(1).projects.delete_all
