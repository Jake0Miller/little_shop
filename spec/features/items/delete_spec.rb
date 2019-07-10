require 'rails_helper'

RSpec.describe 'Delete Item' do
  describe 'As a Visitor' do
    describe 'When I visit an items show page' do
      before :each do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
        @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
        @review_1 = @giant.reviews.create!(title: 'Amazing!', content: 'The best Giant I ever saw!', rating: 5)
        @order = Order.create!(name: 'Bob', address: '123', city: 'LA', state: 'CA', zip: '80222')
        @order.add_items({@hippo => 1})
      end

      it 'I can click a link to delete that item' do
        visit item_path(@giant)

        expect(page).to have_content('Reviews')
        expect(page).to have_content('Title: Amazing!')
        expect(page).to have_content('Rating: 5')
        expect(page).to have_content('The best Giant I ever saw')
        
        expect(Review.find(@review_1.id)).to eq(@review_1)

        expect {@review_1.destroy}.to change(Review, :count).by(-1)
        expect(Review.all).to_not include(@review_1)
        click_link 'Delete'

        expect(current_path).to eq(items_path)

        expect(page).to have_css("#item-#{@ogre.id}")
        expect(page).to have_css("#item-#{@hippo.id}")
        expect(page).to_not have_css("#item-#{@giant.id}")

        visit item_path(@hippo)
        click_link 'Delete'

        expect(page).to have_content('This item has been ordered and cannot be deleted!')
        expect(current_path).to eq(item_path(@hippo))
      end
    end
  end
end
