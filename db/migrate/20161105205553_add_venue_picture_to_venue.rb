class AddVenuePictureToVenue < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :venue_picture, :string
  end
end
