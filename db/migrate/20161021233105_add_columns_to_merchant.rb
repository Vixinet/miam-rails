class AddColumnsToMerchant < ActiveRecord::Migration[5.0]
  def change
    add_column :merchants, :title, :string
    add_column :merchants, :email, :string
    add_column :merchants, :phone, :string
    add_column :merchants, :website, :string
    add_column :merchants, :address, :string
    add_column :merchants, :city, :string
    add_column :merchants, :zipcode, :string
    add_column :merchants, :price, :integer
    add_column :merchants, :delivery_cost, :float
    add_column :merchants, :free_delivery_limit, :float
    add_column :merchants, :small_order_surcharge, :float
    add_column :merchants, :maximum_distance, :float
    add_column :merchants, :long_delivery_surcharge, :float
  end
end