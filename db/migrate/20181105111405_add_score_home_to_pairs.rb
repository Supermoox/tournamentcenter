class AddScoreHomeToPairs < ActiveRecord::Migration[5.1]
  def change
    add_column :pairs, :score_home, :integer
  end
end
