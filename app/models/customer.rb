# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  phone      :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_customers_on_email  (email) UNIQUE
#

class Customer < ActiveRecord::Base
  has_many :invoices, dependent: :destroy
end
