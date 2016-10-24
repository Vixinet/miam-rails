class CreateProductGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :product_groups do |t|
      t.string :label
      t.string :description
      t.integer :order
      t.references :venue, foreign_key: true

      t.timestamps
    end
  end
end
