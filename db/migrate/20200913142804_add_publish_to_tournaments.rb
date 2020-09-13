class AddPublishToTournaments < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :publish, :boolean, default: false
  end
end
