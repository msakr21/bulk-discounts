class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def update_matching_invoice_items
    InvoiceItem.joins(:item, :invoice, :bulk_discount)
               .where("items.merchant_id = ? AND quantity >= ? AND invoice_items.status != 2 AND invoices.status != 2 AND bulk_discounts.threshold <= ? AND bulk_discounts.amount < ?", self.merchant_id, self.threshold, self.threshold, self.amount)
               .update_all(bulk_discount_id: self.id)
  end

  def pending_invoices?
    invoices.where('invoices.status = 0').present?
  end
end