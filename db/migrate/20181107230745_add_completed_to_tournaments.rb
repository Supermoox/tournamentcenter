class AddCompletedToTournaments < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :completed, :boolean
  end
end
