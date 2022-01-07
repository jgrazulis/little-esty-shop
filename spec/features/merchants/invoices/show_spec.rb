require 'rails_helper'

RSpec.describe 'Merchant Invoice Show Page', type: :feature do

  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}
  let!(:merchant_2) {Merchant.create!(name: 'Deb Millhouse')}

  let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 150)}
  let!(:item_2) {merchant_1.items.create!(name: "Bracelet", description: "A thing around your wrist", unit_price: 300)}
  let!(:item_3) {merchant_2.items.create!(name: "Earrings", description: "A thing around your ears", unit_price: 220)}
  let!(:item_4) {merchant_2.items.create!(name: "Button", description: "A thing for your pants", unit_price: 150)}

  let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}

  let!(:invoice_1)  {customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')}

  let!(:invoice_item_1) {InvoiceItem.create!(quantity: 3, unit_price: item_1.unit_price, item_id: item_1.id, invoice_id: invoice_1.id, status: 0)}
  let!(:invoice_item_2) {InvoiceItem.create!(quantity: 5, unit_price: item_2.unit_price, item_id: item_2.id, invoice_id: invoice_1.id, status: 0)}
  let!(:invoice_item_3) {InvoiceItem.create!(quantity: 1, unit_price: item_3.unit_price, item_id: item_3.id, invoice_id: invoice_1.id, status: 0)}
  let!(:invoice_item_4) {InvoiceItem.create!(quantity: 1, unit_price: item_4.unit_price, item_id: item_4.id, invoice_id: invoice_1.id, status: 0)}

  let!(:transaction_1) {invoice_1.transactions.create!(result: 'success')}

  before (:each) do
    visit merchant_invoice_path(merchant_1.id, invoice_1.id)
  end

  describe 'Merchant sees invoice attributes on page' do
    it 'displays invoice id' do
      expect(page).to have_content(invoice_1.id)
    end

    it 'displays invoice status' do
      expect(page).to have_content(invoice_1.status)
    end

    it 'displays invoice created_at date in format DAY, MM DD,YYYY' do
      expect(page).to have_content("Sunday, March 25, 2012")
    end

    it 'displays customer first and last name' do
      expect(page).to have_content("First Name: #{customer_1.first_name}")
      expect(page).to have_content("Last Name: #{customer_1.last_name}")
    end
  end

  describe 'merchant item information displays' do
    scenario 'merchant sees information for only their items associated with invoice including item name, quantity, price, status' do
      expect(page).to have_no_content(item_3.name)
      expect(page).to have_no_content(item_4.name)

      within "#item#{item_1.id}" do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(invoice_item_1.quantity)
        expect(page).to have_content(invoice_item_1.status)
        expect(page).to have_content(invoice_item_1.unit_price)
      end

      within "#item#{item_2.id}" do
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(invoice_item_2.quantity)
        expect(page).to have_content(invoice_item_2.status)
        expect(page).to have_content(invoice_item_2.unit_price)
      end
    end
  end
end
