# == Schema Information
#
# Table name: invoices
#
#  id          :integer          not null, primary key
#  number      :integer
#  issue_date  :date
#  due_date    :date
#  customer_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_invoices_on_customer_id  (customer_id)
#  index_invoices_on_number       (number) UNIQUE
#

class Invoice < ActiveRecord::Base
  has_many :invoice_items, dependent: :destroy
  belongs_to :customer

  before_create :create_unique_identifier

  def total
    self.invoice_items.each.inject(0) { |sum, i| sum += i.amount }
  end

  def subtotal
    self.invoice_items.each.inject(0) { |sum, i| sum += i.unitary_cost }
  end

  def invoice_path
    "#{Rails.root}/pdfs/invoice-#{self.number}.pdf"
  end

private

  def create_unique_identifier
    begin
      self[:number] = SecureRandom.random_number(1_000_000)
    end while self.class.exists?(number: number)
  end
end
