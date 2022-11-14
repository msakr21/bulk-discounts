require 'csv'

namespace :csv_load do
  task customers: :environment do
    csv = CSV.foreach("././db/data/customers.csv", :headers => true) do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  task merchants: :environment do
    csv = CSV.foreach("././db/data/merchants.csv", :headers => true) do |row|
      Merchant.create!(row.to_hash)
      BulkDiscount.create!(amount: 0, threshold: 0, merchant_id: row["id"], id: row["id"])
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    ActiveRecord::Base.connection.reset_pk_sequence!('bulk_discounts')
  end

  task items: :environment do
    csv = CSV.foreach("././db/data/items.csv", :headers => true) do |row|
      Item.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  task invoice_items: :environment do
    csv = CSV.foreach("././db/data/invoice_items.csv", :headers => true) do |row|
      InvoiceItem.create!(:id => row["id"],
                          :invoice_id => row["invoice_id"],
                          :item_id => row["item_id"],
                          :quantity => row["quantity"],
                          :unit_price => row["unit_price"],
                          :status => row["status"],
                          :bulk_discount_id => Item.find(row["item_id"]).merchant_id,
                          :created_at => row["created_at"],
                          :updated_at => row["updated_at"])
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  task invoices: :environment do
    csv = CSV.foreach("././db/data/invoices.csv", :headers => true) do |row|
      Invoice.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  task transactions: :environment do
    csv = CSV.foreach("././db/data/transactions.csv", :headers => true) do |row|
      Transaction.create!(:id => row["id"],
                          :invoice_id => row["invoice_id"],
                          :credit_card_number => row["credit_card_number"],
                          :result => row["result"],
                          :created_at => row["created_at"],
                          :updated_at => row["updated_at"])
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  task all: :environment do
    Rake::Task["csv_load:customers"].execute
    Rake::Task["csv_load:invoices"].execute
    Rake::Task["csv_load:merchants"].execute
    Rake::Task["csv_load:items"].execute
    Rake::Task["csv_load:transactions"].execute
    Rake::Task["csv_load:invoice_items"].execute
  end
end
