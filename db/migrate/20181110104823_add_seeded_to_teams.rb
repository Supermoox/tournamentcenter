class AddSeededToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :seeded, :boolean
  end
end
