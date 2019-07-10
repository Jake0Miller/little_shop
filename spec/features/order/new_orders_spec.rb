require 'rails_helper'

RSpec.describe 'New Order Creation' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      visit item_path(@ogre)
      click_link "Add to Cart"
      visit item_path(@hippo)
      click_link "Add to Cart"
      visit item_path(@giant)
      click_link "Add to Cart"
      visit cart_path
      click_link 'Checkout'
    end

    it 'I can use the new order form to create a new order' do
      visit new_order_path

      within "#item-#{@ogre.id}" do
        expect(page).to have_content("#{@ogre.name}")
        expect(page).to have_content("#{@ogre.merchant.name}")
      end

      within "#item-#{@hippo.id}" do
        expect(page).to have_content("#{@hippo.name}")
        expect(page).to have_content("#{@hippo.merchant.name}")
      end

      within "#item-#{@giant.id}" do
        expect(page).to have_content("#{@giant.name}")
        expect(page).to have_content("#{@giant.merchant.name}")
      end

      name = 'Logan Marma'
      address = '123 Tree St'
      city = "Denver"
      state = "CO"
      zip = 80237

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      expect(page).to have_content("Total")
      expect(page).to have_content("Name")
      expect(page).to have_content("Address")
      expect(page).to have_content("City")
      expect(page).to have_content("State")
      expect(page).to have_content("Zip")
      expect(page).to have_button("Create Order")

      click_button 'Create Order'

      # expect(current_path).to eq(orders_path(@order.id))
    end
  end
end
