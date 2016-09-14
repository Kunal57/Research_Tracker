class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :professor_id, null: false
      t.string  :status, null: false, default: "pending"
      # project statuses: "pending", "active", "complete"
      t.string  :title, null: false
      t.text    :hypothesis, null: false
      t.text    :summary, null: false
      t.text    :conclusion
      t.integer :time_budget, null: false

      t.timestamps null: false
    end
  end
end
