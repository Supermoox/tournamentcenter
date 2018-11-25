class AddAwayTeamToPairs < ActiveRecord::Migration[5.1]
  def change
    add_column :pairs, :away_team, :string
  end
end
