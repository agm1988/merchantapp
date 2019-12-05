class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants do |t|
      t.text :name
      t.text :description
      t.string :email
      t.integer :status, null: false, default: 0
      t.decimal :total_transaction_sum, precision: 10, scale: 2

      t.timestamps
    end
  end
end
