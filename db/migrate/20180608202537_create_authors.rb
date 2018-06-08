class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :jap, default: 'Unknown'
      t.string :rom, default: 'Unknown'
      t.string :eng, default: 'Unknown'

      t.timestamps
    end
  end
end
