class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string  :name, null: false
      t.string  :email, null: false, unique: true
      t.string  :password_digest, null: false
      t.boolean :is_approved, null: false
      t.boolean :is_admin, null: false, default: false

      t.timestamps null: false
    end
  end
end
