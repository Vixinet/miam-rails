class CreateOptIns < ActiveRecord::Migration[5.0]
  def change
    create_table :opt_ins do |t|
      t.string :email

      t.timestamps
    end
  end
end
