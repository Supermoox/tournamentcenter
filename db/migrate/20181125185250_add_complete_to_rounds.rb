class AddCompleteToRounds < ActiveRecord::Migration[5.1]
  def change
    add_column :rounds, :complete, :boolean
  end
end
