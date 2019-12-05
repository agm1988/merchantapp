class AddReferenceUuidToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :reference_uuid, :string, index: true
  end
end
