class AddEndedToPairs < ActiveRecord::Migration[5.1]
  def change
    add_column :pairs, :ended, :boolean
  end
end
