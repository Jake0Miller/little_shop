require 'rails_helper'

RSpec.describe 'Destroy Existing Merchant' do
  describe 'As a visitor' do
    it 'I can click button to destroy merchant from database' do
      brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      visit merchant_path(brian.id)

      click_button 'Delete'

      expect(current_path).to eq(merchants_path)
      expect(page).to_not have_content(brian.name)
    end

    it 'I can click button to destroy merchant from database' do
      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      visit merchant_path(megan.id)

      click_button 'Delete'

      expect(page).to have_content('This merchant has items and cannot be deleted!')

      expect(current_path).to eq(merchant_path(megan))
      expect(page).to have_content(megan.name)
    end
  end
end
