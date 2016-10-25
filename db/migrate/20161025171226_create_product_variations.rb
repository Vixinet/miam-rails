class CreateProductVariations < ActiveRecord::Migration[5.0]
  def change
    create_table :product_variations do |t|
      t.string :label
      t.boolean :allow_multi_choices, :default => false
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
