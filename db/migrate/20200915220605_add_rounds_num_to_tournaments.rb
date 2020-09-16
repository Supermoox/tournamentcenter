class AddRoundsNumToTournaments < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :rounds_num, :integer
  end
end
