class AddStatusToProductGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :product_groups, :status, :integer
  end
end
