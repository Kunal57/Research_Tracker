class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string  :name, null: false
      t.string  :email, null: false, unique: true
      t.string  :password_digest, null: false

      t.timestamps null: false
    end
  end
end
