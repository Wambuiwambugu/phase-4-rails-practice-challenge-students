class AddAgeToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :age, :string
  end
end
