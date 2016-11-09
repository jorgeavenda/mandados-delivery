class AddMediaToMediaFiles < ActiveRecord::Migration
  def self.up
    add_attachment :media_files, :media
  end

  def self.down
    remove_attachment :media_files, :media
  end
end
