class AddDefaultOrderToVariationOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :variation_options, :default, :boolean, :default => false
    add_column :variation_options, :order, :integer
  end
end
