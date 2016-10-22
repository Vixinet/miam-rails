class AddStatusToMerchant < ActiveRecord::Migration[5.0]
  def change
    add_column :merchants, :status, :integer
  end
end
