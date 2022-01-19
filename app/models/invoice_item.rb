class InvoiceItem < ApplicationRecord
  enum status: ["packaged", "pending", "shipped"]

  validates_presence_of :quantity,
                        :unit_price,
                        :item_id,
                        :invoice_id


  belongs_to :invoice
  belongs_to :item

  def self.revenue
      sum('quantity * unit_price')
  end

  def self.bulk_discount_20?
    require 'pry'; binding.pry
    item.quantity == 10
  end
end
