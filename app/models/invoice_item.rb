# == Schema Information
#
# Table name: invoice_items
#
#  id           :integer          not null, primary key
#  quantity     :integer          default(1)
#  description  :string(255)
#  unitary_cost :decimal(15, 3)
#  invoice_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_invoice_items_on_invoice_id  (invoice_id)
#

class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice

  def amount
    self[:unitary_cost] * self[:quantity]
  end
end
