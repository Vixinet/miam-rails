class CreateAdminVariationOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :variation_options do |t|
      t.string :label
      t.boolean :allow_multi_choices, :default => false
      t.float :price_variation, :default => 0
      t.references :product_variation, foreign_key: true

      t.timestamps
    end
  end
end
