class AddColumnsToVenue < ActiveRecord::Migration[5.0]
  def change
    add_reference :venues, :city, foreign_key: true
    add_column :venues, :accepts_take_away, :boolean
    add_column :venues, :accepts_delivery, :boolean
  end
end
