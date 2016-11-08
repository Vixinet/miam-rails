class AddVenueToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :venue, foreign_key: true
  end
end
