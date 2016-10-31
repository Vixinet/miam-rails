class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :credits, :float, :default => 0
    add_column :users, :invitation_code, :string
    add_column :users, :phone, :string
    add_column :users, :name, :string
  end
end
