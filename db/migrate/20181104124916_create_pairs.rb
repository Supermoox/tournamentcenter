class CreatePairs < ActiveRecord::Migration[5.1]
  def change
    create_table :pairs do |t|
      t.integer :home
      t.integer :away
      t.references :round, foreign_key: true

      t.timestamps
    end
  end
end
