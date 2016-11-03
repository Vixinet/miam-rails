class AddOrderToProductVariations < ActiveRecord::Migration[5.0]
  def change
    add_column :product_variations, :order, :integer
  end
end
