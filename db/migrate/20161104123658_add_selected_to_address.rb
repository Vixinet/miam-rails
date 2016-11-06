class AddSelectedToAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :selected, :boolean, :default => false
  end
end
