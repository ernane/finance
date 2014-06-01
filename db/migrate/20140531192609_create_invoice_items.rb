class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :quantity, default: 1
      t.string :description
      t.decimal :unitary_cost, precision: 15, scale: 3
      t.references :invoice, index: true

      t.timestamps
    end
  end
end
