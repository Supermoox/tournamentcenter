class AddAttachmentImageToTournaments < ActiveRecord::Migration[5.1]
  def self.up
    change_table :tournaments do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :tournaments, :image
  end
end
