class AddMultiChoiceLimitToProductVariations < ActiveRecord::Migration[5.0]
  def change
    add_column :product_variations, :multi_choice_limit, :integer, :default => 0
  end
end
