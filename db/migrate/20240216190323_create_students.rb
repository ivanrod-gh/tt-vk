class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :sur_name, null: false

      t.belongs_to :klass, foreign_key: true
      t.timestamps
    end
  end
end
