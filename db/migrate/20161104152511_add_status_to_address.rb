class AddStatusToAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :status, :integer
  end
end
