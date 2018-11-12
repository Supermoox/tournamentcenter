class AddNumToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :num, :integer
  end
end
