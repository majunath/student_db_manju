class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :full_name
      t.text :address
      t.string :email
      t.string :mobile
      t.integer :institution_id

      t.timestamps
    end
  end
end
