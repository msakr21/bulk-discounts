require 'holiday_spec'
require 'rails_helper'

RSpec.describe 'bulk discounts index page' do
  before :each do
    @response_body = "[{\"date\":\"2022-11-24\",\"localName\":\"Thanksgiving Day\",\"name\":\"Thanksgiving Day\",\"countryCode\":\"US\",\"fixed\":false,\"global\":true,\"counties\":null,\"launchYear\":1863,\"types\":[\"Public\"]},{\"date\":\"2022-12-26\",\"localName\":\"Christmas Day\",\"name\":\"Christmas Day\",\"countryCode\":\"US\",\"fixed\":false,\"global\":true,\"counties\":null,\"launchYear\":null,\"types\":[\"Public\"]},{\"date\":\"2023-01-02\",\"localName\":\"New Year's Day\",\"name\":\"New Year's Day\",\"countryCode\":\"US\",\"fixed\":false,\"global\":true,\"counties\":null,\"launchYear\":null,\"types\":[\"Public\"]},{\"date\":\"2023-01-16\",\"localName\":\"Martin Luther King, Jr. Day\",\"name\":\"Martin Luther King, Jr. Day\",\"countryCode\":\"US\",\"fixed\":false,\"global\":true,\"counties\":null,\"launchYear\":null,\"types\":[\"Public\"]},{\"date\":\"2023-02-20\",\"localName\":\"Presidents Day\",\"name\":\"Washington's Birthday\",\"countryCode\":\"US\",\"fixed\":false,\"global\":true,\"counties\":null,\"launchYear\":null,\"types\":[\"Public\"]}]"

  @base_uri = "https://date.nager.at/api/v3/NextPublicHolidays/US"
  
  stub_request(:get, @base_uri).
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: @response_body, headers: {})

    @crystal_moon = Merchant.create!(name: "Crystal Moon Designs")
    @surf_designs = Merchant.create!(name: "Surf & Co. Designs")
    @merchant_3 = Merchant.create!(name: 'Outer Outfitters')
    @merchant_4 = Merchant.create!(name: 'The Toy Box')
    @merchant_5 = Merchant.create!(name: 'Chiseled Features')
    @merchant_6 = Merchant.create!(name: 'Quilting Corner')

    @default_price_1 = @crystal_moon.bulk_discounts.create!(amount: 0, threshold: 0)
    @default_price_2 = @surf_designs.bulk_discounts.create!(amount: 0, threshold: 0)
    @default_price_3 = @merchant_3.bulk_discounts.create!(amount: 0, threshold: 0)
    @default_price_4 = @merchant_4.bulk_discounts.create!(amount: 0, threshold: 0)
    @default_price_5 = @merchant_5.bulk_discounts.create!(amount: 0, threshold: 0)
    @default_price_6 = @merchant_6.bulk_discounts.create!(amount: 0, threshold: 0)
    @discount_price_1 = @crystal_moon.bulk_discounts.create!(amount: 10, threshold: 10)
    @discount_price_2 = @surf_designs.bulk_discounts.create!(amount: 15, threshold: 10)
    @surprise_and_delight = @crystal_moon.bulk_discounts.create!(amount: 20, threshold: 15)

    @pearl = @crystal_moon.items.create!(name: "Pearl", description: "Not a BlackPearl!", unit_price: 25)
    @moon_rock = @crystal_moon.items.create!(name: "Moon Rock", description: "Evolve Your Pokemon!", unit_price: 105)
    @lapis_lazuli = @crystal_moon.items.create!(name: "Lapis Lazuli", description: "Not the Jewel Knight!", unit_price: 45)
    @topaz = @crystal_moon.items.create!(name: "Topaz", description: "Just Another Topaz!", unit_price: 55)
    @amethyst = @crystal_moon.items.create!(name: "Amethyst", description: "Common Loot!", unit_price: 55)
    @emerald = @crystal_moon.items.create!(name: "Emerald", description: "Where's Sonic?", unit_price: 85)
    @ruby = @crystal_moon.items.create!(name: "Ruby", description: "Razzle Dazzle?", unit_price: 65)
    @sapphire = @crystal_moon.items.create!(name: "Sapphire", description: "Deep Blue!", unit_price: 45)
    @dream_catcher = @crystal_moon.items.create!(name: "Midnight Dream Catcher", description: "Catch the magic of your dreams!", unit_price: 25)
    @rose_quartz = @crystal_moon.items.create!(name: "Rose Quartz Pendant", description: "Manifest the love of your life!", unit_price: 37)
    @tarot_deck = @crystal_moon.items.create!(name: "Witchy Tarot Deck", description: "Unveil your true path!", unit_price: 22)
    @wax = @surf_designs.items.create!(name: "Board Wax", description: "Hang ten!", unit_price: 7)
    @rash_guard = @surf_designs.items.create!(name: "Radical Rash Guard", description: "Stay totally groovy and rash free!", unit_price: 50)
    @zinc = @surf_designs.items.create!(name: "100% Zinc Face Protectant", description: "Our original organic formula!", unit_price: 13)
    @surf_board = @surf_designs.items.create!(name: "Surf Board", description: "Our original 12' board!", unit_price: 200)
    @snorkel = @surf_designs.items.create!(name: "Snorkel", description: "Perfect for reef viewing!", unit_price: 400)
    @ball = @merchant_4.items.create!(name: "Ball", description: "Super bouncy", unit_price: 100)
    @statuette = @merchant_5.items.create!(name: "Statuette", description: "Carved from marble", unit_price: 200)
    @quilt = @merchant_6.items.create!(name: "Quilt", description: "Colorful and soft", unit_price: 300)

    @paul = Customer.create!(first_name: "Paul", last_name: "Walker")
    @sam = Customer.create!(first_name: "Sam", last_name: "Gamgee")
    @abbas = Customer.create!(first_name: "Abbas", last_name: "Firnas")
    @hamada = Customer.create!(first_name: "Hamada", last_name: "Hilal")
    @frodo = Customer.create!(first_name: "Frodo", last_name: "Baggins")
    @eevee = Customer.create!(first_name: "Eevee", last_name: "Ketchup")
    @dude = Customer.create!(first_name: "Dude", last_name: "Bruh")

    @invoice_1 = Invoice.create!(status: 2, customer_id: @paul.id)
    @invoice_2 = Invoice.create!(status: 2, customer_id: @paul.id)
    @invoice_3 = Invoice.create!(status: 2, customer_id: @sam.id)
    @invoice_4 = Invoice.create!(status: 2, customer_id: @sam.id)
    @invoice_5 = Invoice.create!(status: 2, customer_id: @abbas.id)
    @invoice_6 = Invoice.create!(status: 2, customer_id: @abbas.id)
    @invoice_7 = Invoice.create!(status: 2, customer_id: @hamada.id)
    @invoice_8 = Invoice.create!(status: 2, customer_id: @hamada.id)
    @invoice_9 = Invoice.create!(status: 2, customer_id: @frodo.id)
    @invoice_10 = Invoice.create!(status: 2, customer_id: @frodo.id)
    @invoice_11 = Invoice.create!(status: 2, customer_id: @eevee.id)
    @invoice_12 = Invoice.create!(status: 2, customer_id: @paul.id)
    @invoice_13 = Invoice.create!(status: 2, customer_id: @sam.id)
    @invoice_14 = Invoice.create!(status: 2, customer_id: @eevee.id)
    @invoice_15 = Invoice.create!(status: 0, customer_id: @eevee.id)
    @invoice_16 = Invoice.create!(status: 2, customer_id: @eevee.id)
    @invoice_17 = Invoice.create!(status: 2, customer_id: @eevee.id)
    @invoice_18 = Invoice.create!(status: 0, customer_id: @paul.id)
    @invoice_19 = Invoice.create!(status: 2, customer_id: @abbas.id)
    @invoice_20 = Invoice.create!(status: 2, customer_id: @frodo.id)
    @invoice_21 = Invoice.create!(status: 2, customer_id: @paul.id)
    @invoice_22 = Invoice.create!(status: 2, customer_id: @eevee.id)
    @invoice_23 = Invoice.create!(status: 2, customer_id: @dude.id)

    @pearl_invoice = InvoiceItem.create!(item_id: @pearl.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 25, status: 1, bulk_discount_id: @default_price_1.id)
    @moon_rock_invoice = InvoiceItem.create!(item_id: @moon_rock.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 105, status: 1, bulk_discount_id: @default_price_1.id)
    @lapis_lazuli_invoice = InvoiceItem.create!(item_id: @lapis_lazuli.id, invoice_id: @invoice_3.id, quantity: 2, unit_price: 45, status: 1, bulk_discount_id: @default_price_1.id)
    @topaz_invoice = InvoiceItem.create!(item_id: @topaz.id, invoice_id: @invoice_4.id, quantity: 2, unit_price: 55, status: 1, bulk_discount_id: @default_price_1.id)
    @amethyst_invoice = InvoiceItem.create!(item_id: @amethyst.id, invoice_id: @invoice_5.id, quantity: 2, unit_price: 55, status: 2, bulk_discount_id: @default_price_1.id)
    @emerald_invoice = InvoiceItem.create!(item_id: @emerald.id, invoice_id: @invoice_6.id, quantity: 2, unit_price: 85, status: 2, bulk_discount_id: @default_price_1.id)
    @ruby_invoice = InvoiceItem.create!(item_id: @ruby.id, invoice_id: @invoice_7.id, quantity: 2, unit_price: 65, status: 2, bulk_discount_id: @default_price_1.id)
    @sapphire_invoice = InvoiceItem.create!(item_id: @sapphire.id, invoice_id: @invoice_8.id, quantity: 2, unit_price: 45, status: 2, bulk_discount_id: @default_price_1.id)
    @dream_catcher_invoice = InvoiceItem.create!(item_id: @dream_catcher.id, invoice_id: @invoice_9.id, quantity: 2, unit_price: 25, status: 2, bulk_discount_id: @default_price_1.id)
    @rose_quartz_invoice = InvoiceItem.create!(item_id: @rose_quartz.id, invoice_id: @invoice_10.id, quantity: 2, unit_price: 37, status: 2, bulk_discount_id: @default_price_1.id)
    @tarot_deck_invoice = InvoiceItem.create!(item_id: @tarot_deck.id, invoice_id: @invoice_11.id, quantity: 2, unit_price: 22, status: 2, bulk_discount_id: @default_price_1.id)
    @wax_invoice = InvoiceItem.create!(item_id: @wax.id, invoice_id: @invoice_12.id, quantity: 2, unit_price: 7, status: 2, bulk_discount_id: @default_price_2.id)
    @rash_guard_invoice = InvoiceItem.create!(item_id: @rash_guard.id, invoice_id: @invoice_13.id, quantity: 2, unit_price: 50, status: 2, bulk_discount_id: @default_price_2.id)
    @zinc_invoice = InvoiceItem.create!(item_id: @zinc.id, invoice_id: @invoice_14.id, quantity: 2, unit_price: 13, status: 1, bulk_discount_id: @default_price_2.id)
    @surf_board_invoice = InvoiceItem.create!(item_id: @surf_board.id, invoice_id: @invoice_6.id, quantity: 2, unit_price: 200, status: 1, bulk_discount_id: @default_price_2.id)
    @ball_invoice = InvoiceItem.create!(item_id: @ball.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: 100, status: 1, bulk_discount_id: @default_price_4.id)
    @statuette_invoice = InvoiceItem.create!(item_id: @statuette.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: 200, status: 1, bulk_discount_id: @default_price_5.id)
    @quilt_invoice = InvoiceItem.create!(item_id: @quilt.id, invoice_id: @invoice_6.id, quantity: 1, unit_price: 300, status: 1, bulk_discount_id: @default_price_6.id)
    @moon_rock_invoice_2 = InvoiceItem.create!(item_id: @moon_rock.id, invoice_id: @invoice_23.id, quantity: 2, unit_price: 105, status: 1, bulk_discount_id: @default_price_1.id)

    @transaction_1 = Transaction.create!(result: 1, invoice_id: @invoice_1.id, credit_card_number: 0001)
    @transaction_2 = Transaction.create!(result: 1, invoice_id: @invoice_2.id, credit_card_number: 0002)
    @transaction_3 = Transaction.create!(result: 1, invoice_id: @invoice_3.id, credit_card_number: 0003)
    @transaction_4 = Transaction.create!(result: 1, invoice_id: @invoice_4.id, credit_card_number: 0004)
    @transaction_5 = Transaction.create!(result: 1, invoice_id: @invoice_5.id, credit_card_number: 0005)
    @transaction_6 = Transaction.create!(result: 1, invoice_id: @invoice_6.id, credit_card_number: 0006)
    @transaction_7 = Transaction.create!(result: 1, invoice_id: @invoice_7.id, credit_card_number: 0007)
    @transaction_8 = Transaction.create!(result: 1, invoice_id: @invoice_8.id, credit_card_number: 0010)
    @transaction_9 = Transaction.create!(result: 1, invoice_id: @invoice_9.id, credit_card_number: 0011)
    @transaction_10 = Transaction.create!(result: 1, invoice_id: @invoice_10.id, credit_card_number: 0012)
    @transaction_11 = Transaction.create!(result: 1, invoice_id: @invoice_11.id, credit_card_number: 0013)
    @transaction_12 = Transaction.create!(result: 1, invoice_id: @invoice_12.id, credit_card_number: 0014)
    @transaction_13 = Transaction.create!(result: 1, invoice_id: @invoice_13.id, credit_card_number: 0015)
    @transaction_14 = Transaction.create!(result: 1, invoice_id: @invoice_14.id, credit_card_number: 0016)
    @transaction_15 = Transaction.create!(result: 1, invoice_id: @invoice_15.id, credit_card_number: 0016)
    @transaction_16 = Transaction.create!(result: 1, invoice_id: @invoice_16.id, credit_card_number: 0016)
    @transaction_17 = Transaction.create!(result: 1, invoice_id: @invoice_17.id, credit_card_number: 0016)
    @transaction_18 = Transaction.create!(result: 1, invoice_id: @invoice_18.id, credit_card_number: 0016)
    @transaction_19 = Transaction.create!(result: 1, invoice_id: @invoice_19.id, credit_card_number: 0016)
    @transaction_20 = Transaction.create!(result: 1, invoice_id: @invoice_20.id, credit_card_number: 0016)
    @transaction_21 = Transaction.create!(result: 0, invoice_id: @invoice_21.id, credit_card_number: 0016)
    @transaction_22 = Transaction.create!(result: 0, invoice_id: @invoice_17.id, credit_card_number: 0016)
    @transaction_23 = Transaction.create!(result: 1, invoice_id: @invoice_23.id, credit_card_number: 0016)
  end

  it "displays a list of the merchant's bulk discounts" do
    visit merchant_bulk_discounts_path(@crystal_moon)

    expect(page).to have_content("10%, Quantity Threshold: 10")
    expect(page).to have_link("10%")
    expect(page).to have_content("20%, Quantity Threshold: 15")
    expect(page).to have_link("20%")

    visit merchant_bulk_discounts_path(@surf_designs)

    expect(page).to have_content("15%, Quantity Threshold: 10")
    expect(page).to have_link("15%")
  end

  it "has a link to create a new discount" do
    visit merchant_bulk_discounts_path(@crystal_moon)

    expect(page).to have_link("Create New Discount")
    click_link "Create New Discount"
    expect(current_path).to eql(new_merchant_bulk_discount_path(@crystal_moon))
  end

  it 'has a link next to each bulk discount to delete it' do
    visit merchant_bulk_discounts_path(@crystal_moon)
    
    expect(page).to have_link("Delete", count: 2)
  end

  it 'has a section for upcoming holidays' do
    holidays = Holiday.new.next_3_holidays

    visit merchant_bulk_discounts_path(@crystal_moon)
    
    expect(page).to have_content("Upcoming Holidays")
    expect(page).to have_content("Holiday: Thanksgiving Day, Date: 2022-11-24")
    expect(page).to have_content("Holiday: Christmas Day, Date: 2022-12-26")
    expect(page).to have_content("Holiday: New Year's Day, Date: 2023-01-02")
  end

  it 'does not display a delete link next to discounts that have pending invoices' do
    moon_rock_invoice_3 = InvoiceItem.create!(item_id: @moon_rock.id, invoice_id: @invoice_15.id, quantity: 2, unit_price: 105, status: 1, bulk_discount_id: @discount_price_1.id)

    visit merchant_bulk_discounts_path(@crystal_moon)

    expect(page).to have_link("Delete", count: 1)

    within "#10" do
      expect(page).to_not have_link("Delete")
    end
  end
end