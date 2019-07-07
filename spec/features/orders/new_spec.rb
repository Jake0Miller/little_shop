require 'rails_helper'

RSpec.describe 'New Order' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      visit item_path(@ogre)
      click_link "Add to Cart"
      visit item_path(@ogre)
      click_link "Add to Cart"
      click_link "Checkout"
    end

    it 'I see a new order page' do
      
    end
  end
end
