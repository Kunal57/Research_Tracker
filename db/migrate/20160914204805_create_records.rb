class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :student_id, null: false
      t.integer :project_id, null: false
      t.integer :hours_worked
      t.text    :observations

      t.timestamps null: false
    end
  end
end
