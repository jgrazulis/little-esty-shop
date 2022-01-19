require 'rails_helper'
RSpec.describe 'bulk discounts index' do
  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}
  
  scenario 'merchant sees link to create new bulk discount' do
    visit "/merchants/#{merchant_1.id}/bulk_discounts"
    expect(page).to have_link("Create New Discount")
    click_link "Create New Discount"
    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/new")
  end
end