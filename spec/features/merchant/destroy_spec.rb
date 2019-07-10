require 'rails_helper'

RSpec.describe 'Destroy Existing Merchant' do
  describe 'As a visitor' do
    before :each do
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      # @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      # @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      # @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end

    it 'I can click button to destroy merchant from database' do
      visit merchant_path(@brian)

      click_button 'Delete'

      expect(current_path).to eq(merchants_path)
      expect(page).to_not have_content(@brian.name)
    end

    it 'I can click button to destroy merchant from database' do
      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      ogre_1 = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      ogre_2 = @brian.items.create!(name: 'Giant', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      order = Order.create!(name: 'Bob', address: '123', city: 'LA', state: 'CA', zip: '80222')
      order.add_items({ogre_2 => 1})
      visit merchant_path(megan)
      click_button 'Delete'

      expect(current_path).to eq(merchants_path)
      expect(page).to_not have_content(megan.name)

      visit merchant_path(@brian)
      click_button 'Delete'

      expect(page).to have_content('You cannot delete this merchant.')
      expect(current_path).to eq(merchant_path(@brian))
    end
  end
end
