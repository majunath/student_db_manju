class AddScoreToStudents < ActiveRecord::Migration[5.2]
  def change
  	add_column :students, :score, :integer
  end
end
