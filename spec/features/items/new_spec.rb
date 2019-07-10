require 'rails_helper'

RSpec.describe 'New Merchant Item' do
  describe 'As a Visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    end

    it 'I can click a link to a new item form page' do
      visit merchant_items_path(@megan)

      click_link 'New Item'

      expect(current_path).to eq(new_item_path(@megan))
    end

    it 'I can create an item for a merchant' do
      name = 'Ogre'
      description = "I'm an Ogre!"
      price = 20
      image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'
      inventory = 5
      visit new_item_path(@megan)

      fill_in 'Name', with: name
      fill_in 'Description', with: description
      fill_in 'Price', with: price
      fill_in 'Image', with: image
      fill_in 'Inventory', with: inventory
      click_button 'Create Item'

      expect(current_path).to eq(merchant_items_path(@megan))
      expect(page).to have_link(name)
      expect(page).to have_content(description)
      # expect(page).to have_content("Price: #{number_to_currency(price)}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{inventory}")
    end

    it 'I see a flash message when info is missing' do
      name = 'Ogre'
      description = "I'm an Ogre!"
      price = 20
      image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw'
      inventory = 5
      visit merchant_path(@megan)
      click_button 'New Item'

      expect(current_path).to eq(new_item_path(@megan))

      click_button 'Create Item'

      expect(page).to have_content('Missing name!')

      fill_in :name, with: name
      click_button 'Create Item'

      expect(current_path).to eq(merchant_items_path(@megan))
      expect(page).to have_content('Missing description!')
      expect(find_field(:name).value).to eq(name)

      fill_in :description, with: description
      click_button 'Create Item'

      expect(current_path).to eq(merchant_items_path(@megan))
      expect(page).to have_content('Missing price!')
      expect(find_field(:name).value).to eq(name)
      expect(find_field(:description).value).to eq(description)

      fill_in :price, with: price
      click_button 'Create Item'

      expect(current_path).to eq(merchant_items_path(@megan))
      expect(page).to have_content('Missing image!')
      expect(find_field(:name).value).to eq(name)
      expect(find_field(:description).value).to eq(description)
      expect(find_field(:price).value).to eq('20.0')

      fill_in :image, with: image
      click_button 'Create Item'

      expect(current_path).to eq(merchant_items_path(@megan))
      expect(page).to have_content('Missing inventory!')
      expect(find_field(:name).value).to eq(name)
      expect(find_field(:description).value).to eq(description)
      expect(find_field(:price).value).to eq('20.0')
      expect(find_field(:image).value).to eq(image)

      fill_in :inventory, with: inventory
      click_button 'Create Item'

      expect(current_path).to eq(merchant_items_path(@megan))
      expect(page).to have_content(name)
      expect(page).to have_content(description)
      expect(page).to have_content(price)
      expect(page).to have_content(inventory)
    end
  end
end
