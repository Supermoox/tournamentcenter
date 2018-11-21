class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :goals
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
