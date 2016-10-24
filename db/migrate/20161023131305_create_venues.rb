class CreateVenues < ActiveRecord::Migration[5.0]
  def change
    create_table :venues do |t|
      t.integer :status
      t.string :name
      t.string :title
      t.string :phone
      t.string :website

      t.timestamps
    end
  end
end
