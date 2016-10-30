class AddMultiChoiceLimitToVariationOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :variation_options, :multi_choice_limit, :integer, :default => 0
  end
end
