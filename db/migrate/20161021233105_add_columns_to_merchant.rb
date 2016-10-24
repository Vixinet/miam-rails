class AddColumnsToMerchant < ActiveRecord::Migration[5.0]
  def change
    add_column :merchants, :business_name, :string
    add_column :merchants, :business_id, :string
    add_column :merchants, :vat, :string
    add_column :merchants, :address, :string
    add_column :merchants, :city, :string
    add_column :merchants, :zip_code, :string
    add_column :merchants, :contact_person, :string
    add_column :merchants, :phone, :string
    add_column :merchants, :email, :string
  end
end