class AddModeToTournaments < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :mode, :integer
  end
end
