class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :number
      t.date :issue_date
      t.date :due_date
      t.references :customer, index: true

      t.timestamps
    end
    add_index :invoices, :number, unique: true
  end
end
