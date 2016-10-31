class AddLongitudeLatitudeEtcToVenue < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :latitude, :float
    add_column :venues, :longitude, :float
    add_column :venues, :street, :string
    add_column :venues, :city_name, :string
  end
end
