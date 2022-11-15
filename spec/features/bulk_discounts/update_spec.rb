require 'rails_helper' 

RSpec.describe 'edit merchant bulk discount page' do
  it 'takes me to a form that allows me to edit bulk discount' do
    crystal_moon = Merchant.create!(name: "Crystal Moon Designs")
    discount_price_1 = crystal_moon.bulk_discounts.create!(amount: 10, threshold: 10)

    visit merchant_bulk_discount_path(crystal_moon, discount_price_1)

    expect(page).to have_content("Quantity Threshold: 10")
    expect(page).to have_content("Discount Amount: 10%")

    click_link "Edit Discount"
    expect(current_path).to eql(edit_merchant_bulk_discount_path(crystal_moon, discount_price_1))
    
    fill_in "discount_amount", with: 20
    fill_in "quantity_threshold", with: 20
    click_button "Submit"

    expect(current_path).to eql(merchant_bulk_discount_path(crystal_moon, discount_price_1))

    expect(page).to have_content("Quantity Threshold: 20")
    expect(page).to have_content("Discount Amount: 20%")
  end
end