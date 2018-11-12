class AddMoredetailsToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :allowed, :integer
    add_column :teams, :forced, :integer
  end
end
