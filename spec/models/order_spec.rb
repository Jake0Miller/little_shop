require 'rails_helper'

describe Order, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe 'Relationships' do
    it { should have_many :order_items}
    it { should have_many(:items).through(:order_items)}
  end

  describe 'Methods' do
    it 'Returns quantity and price' do
      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      order = Order.create!(name: 'Bob', address: '123', city: 'LA', state: 'CA', zip: '80222')
      order.add_items({ogre => 2})
      expect(OrderItem.get_quantity(ogre)).to eq(2)
      expect(OrderItem.get_price(ogre)).to eq(20.0)
      expect(order.items).to eq([ogre])
      expect(megan.items).to eq([ogre])
      expect(megan.items.first.orders.first).to eq(Order.find(order.id))
    end
  end
end
