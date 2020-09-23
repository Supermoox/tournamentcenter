class AddOrganiserLinkToTournaments < ActiveRecord::Migration[5.1]
  def change
    add_column :tournaments, :organiser_link, :string
  end
end
