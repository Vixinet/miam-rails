class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.references :product_group, foreign_key: true
      t.string :label
      t.string :description
      t.float :base_price
      t.integer :status
      t.integer :order

      t.timestamps
    end
  end
end
