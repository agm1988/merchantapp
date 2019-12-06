class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants do |t|
      t.text :name
      t.text :description
      t.string :email
      t.string :password_digest
      t.integer :status, null: false, default: 0
      t.boolean :is_admin, null: false, default: false
      t.decimal :total_transaction_sum, precision: 10, scale: 2, default: 0

      t.timestamps
    end
  end
end
