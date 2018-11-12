class AddPlayingToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :playing, :boolean
  end
end
