require 'rails_helper' 

RSpec.describe 'create new merchant bulk discount' do
  it 'when the form is filled and submitted, a new bulk discount is created for the merchant and the merchant is redirected to the bulk discount index' do

    crystal_moon = Merchant.create!(name: "Crystal Moon Designs")
    default_price_1 = crystal_moon.bulk_discounts.create!(amount: 0, threshold: 0)

    visit merchant_bulk_discounts_path(crystal_moon)

    expect(page).to have_link("No Discount")
    expect(page).to_not have_link("10%")

    visit new_merchant_bulk_discount_path(crystal_moon)

    fill_in "discount_amount", with: 10
    fill_in "quantity_threshold", with: 15
    click_button "Submit"

    expect(current_path).to eql(merchant_bulk_discounts_path(crystal_moon))

    expect(page).to have_link("No Discount")
    expect(page).to have_link("10%")
  end
end