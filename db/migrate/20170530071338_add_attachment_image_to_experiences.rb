class AddAttachmentImageToExperiences < ActiveRecord::Migration[5.1]
  def self.up
    change_table :experiences do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :experiences, :image
  end
end
