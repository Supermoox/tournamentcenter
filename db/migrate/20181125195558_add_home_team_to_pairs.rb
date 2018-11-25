class AddHomeTeamToPairs < ActiveRecord::Migration[5.1]
  def change
    add_column :pairs, :home_team, :string
  end
end
