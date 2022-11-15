require 'rails_helper' 

RSpec.describe 'edit merchant bulk discount page' do
  it 'takes me to a form that allows me to edit bulk discount' do
    crystal_moon = Merchant.create!(name: "Crystal Moon Designs")

    visit new_merchant_bulk_discount_path(crystal_moon)
    
    expect(page).to have_content("New Bulk Discount Form")
    expect(page).to have_selector(:css, "form")
    expect(page).to have_content("Discount amount:")
    expect(page).to have_field("discount_amount")
    expect(page).to have_content("Quantity threshold:")
    expect(page).to have_field("quantity_threshold")
    expect(page).to have_button("Submit")
  end
end