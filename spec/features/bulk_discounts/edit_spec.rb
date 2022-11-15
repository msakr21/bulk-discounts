require 'rails_helper' 

RSpec.describe 'new merchant bulk discount page' do
  it 'takes me to a form that allows me to add a new bulk discount' do
    crystal_moon = Merchant.create!(name: "Crystal Moon Designs")
    discount_price_1 = crystal_moon.bulk_discounts.create!(amount: 10, threshold: 10)

    visit edit_merchant_bulk_discount_path(crystal_moon, discount_price_1)
    
    expect(page).to have_content("Edit Bulk Discount Form")
    expect(page).to have_selector(:css, "form")
    expect(page).to have_content("Discount amount:")
    expect(page).to have_field("discount_amount", with: discount_price_1.amount)
    expect(page).to have_content("Quantity threshold:")
    expect(page).to have_field("quantity_threshold", with: discount_price_1.threshold)
    expect(page).to have_button("Submit")
  end
end