class AddDetailsToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :wins, :integer
    add_column :teams, :played, :integer
    add_column :teams, :lost, :integer
    add_column :teams, :draws, :integer
  end
end
