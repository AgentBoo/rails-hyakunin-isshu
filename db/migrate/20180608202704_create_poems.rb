class CreatePoems < ActiveRecord::Migration[5.1]
  def change
    create_table :poems do |t|
      t.integer :numeral
      t.string :jap, array: true, default: []
      t.string :rom, array: true, default: []
      t.string :eng, array: true, default: []
      t.references :author, foreign_key: true

      t.timestamps
    end

    add_index :poems, :numeral, unique: true 
  end
end
