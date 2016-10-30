class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.integer :status
      t.string :label
      t.integer :votes, :default => 0

      t.timestamps
    end
  end
end
