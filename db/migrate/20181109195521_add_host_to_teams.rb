class AddHostToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :host, :boolean
  end
end
