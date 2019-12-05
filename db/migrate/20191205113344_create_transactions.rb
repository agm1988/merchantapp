class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :merchant, foreign_key: true
      t.uuid :uuid, default: "uuid_generate_v4()", null: false
      t.decimal :amount, precision: 10, scale: 2
      t.integer :status, bull: false, default: 0
      t.string :type

      t.timestamps
    end
  end
end
