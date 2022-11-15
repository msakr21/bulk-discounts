class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, through: :merchant

  def update_matching_invoice_items
    InvoiceItem.joins(:item, :invoice, :bulk_discount).where("items.merchant_id = ? AND quantity >= ? AND invoice_items.status != 2 AND invoices.status != 2 AND bulk_discounts.threshold < ?", self.merchant_id, self.threshold, self.threshold).update_all(bulk_discount_id: self.id)
  end
end