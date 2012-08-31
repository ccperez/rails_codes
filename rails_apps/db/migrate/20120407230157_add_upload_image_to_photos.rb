class AddUploadImageToPhotos < ActiveRecord::Migration
  def self.up
    add_column :fotoweekly_photos, :image_file_name, :string
    add_column :fotoweekly_photos, :image_content_type, :string
    add_column :fotoweekly_photos, :image_file_size, :integer
  end

  def self.down
    remove_column :fotoweekly_photos, :image_file_name
    remove_column :fotoweekly_photos, :image_content_type
    remove_column :fotoweekly_photos, :image_file_size
  end
end

