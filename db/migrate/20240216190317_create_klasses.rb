class CreateKlasses < ActiveRecord::Migration[6.1]
  def change
    create_table :klasses do |t|
      t.integer :number, null: false
      t.string :letter, null: false
      t.integer :students_count, null: false, default: 0

      t.belongs_to :school, foreign_key: true
      t.timestamps
    end
  end
end
