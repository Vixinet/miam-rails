class AddVenueThumbnailPictureToVenue < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :venue_thumbnail_picture, :string
  end
end
