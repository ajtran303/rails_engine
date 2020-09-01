require 'pry'
require 'csv'

desc "Import CSV data"

task import_csv: :environment do
  Customer.destroy_all
  puts "Customer records destroyed"
  Merchant.destroy_all
  puts "Merchant records destroyed"
  Invoice.destroy_all
  puts "Invoice records destroyed"
  Purchase.destroy_all
  puts "Purchase records destroyed"
  Item.destroy_all
  puts "Item records destroyed"
  InvoiceItem.destroy_all
  puts "InvoiceItem records destroyed"

  puts "Parsing CSV data..."
  def get_seed_params(csv_file_name)
    csv = "./db/csv_data/#{csv_file_name}.csv"
    CSV.foreach(csv, headers: true, header_converters: :symbol).map(&:to_h)
  end

  puts "Seeding Customers table"
  get_seed_params('customers').each do |params|
    params[:id] = params[:id].to_i
    Customer.create!(params)
  end
  puts "Customers table seeded"

  puts "Seeding Merchants table"
  get_seed_params('merchants').each do |params|
    params[:id] = params[:id].to_i
    Merchant.create!(params)
  end
  puts "Merchants table seeded"

  puts "Seeding Invoice table"
  get_seed_params('invoices').each do |params|
    params[:id] = params[:id].to_i
    params[:customer_id] = params[:customer_id].to_i
    params[:merchant_id] = params[:merchant_id].to_i
    Invoice.create!(params)
  end
  puts "Invoice table seeded"

  puts "Seeding Items table"
  get_seed_params('items').each do |params|
    params[:id] = params[:id].to_i
    params[:merchant_id] = params[:merchant_id].to_i
    params[:unit_price] = (params[:unit_price].to_f * 0.01).round(2)
    Item.create!(params)
  end
  puts "Items table seeded"

  puts "Seeding Purchases table"
  get_seed_params('transactions').each do |params|
    params[:id] = params[:id].to_i
    Purchase.create!(params)
  end
  puts "Purchases table seeded"

  puts "Seeding InvoiceItems table"
  get_seed_params('invoice_items').each do |params|
    params[:id] = params[:id].to_i
    params[:item_id] = params[:item_id].to_i
    params[:invoice_id] = params[:invoice_id].to_i
    params[:quantity] = params[:quantity].to_i
    params[:unit_price] = (params[:unit_price].to_f * 0.01).round(2)
    InvoiceItem.create!(params)
  end
  puts "InvoiceItems table seeded"

  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
    puts "#{t.capitalize} Table primary key sequence reset!"
  end

  puts "Database seeded! Task complete."
end
