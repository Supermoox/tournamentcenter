class AddScoreAwayToPairs < ActiveRecord::Migration[5.1]
  def change
    add_column :pairs, :score_away, :integer
  end
end
