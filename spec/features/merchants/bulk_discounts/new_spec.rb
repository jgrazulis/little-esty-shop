require 'rails_helper'
RSpec.describe 'new bulk discount form' do
  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}

  scenario 'merchant sees form to add new bulk discount' do
    visit "/merchants/#{merchant_1.id}/bulk_discounts/new"
    fill_in('percentage', with: '20%')
    fill_in('number_of_items', with: '5')
    click_button('Submit')
    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts")
  end
end