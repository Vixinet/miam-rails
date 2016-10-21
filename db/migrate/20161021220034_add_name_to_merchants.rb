class AddNameToMerchants < ActiveRecord::Migration[5.0]
  def change
    add_column :merchants, :name, :string
  end
end
