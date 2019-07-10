class Merchant < ApplicationRecord
  has_many :items
  validates_presence_of :name, :address, :city, :state, :zip

  def total_inventory
    self.items.count
  end

  def ave_item_price
    self.items.average(:price)
  end

  def cities
    self.items.joins(:orders).distinct("orders.city").order("orders.city").pluck("orders.city")
  end

  def has_items_in_orders?
    self.items.joins(:order_items).exists?
  end

  def top_three_items
    items.joins(:reviews).order("reviews.rating desc").limit(3)
  end

  def cities_served
    items.joins(:orders).order("orders.city").distinct.pluck("orders.city")
  end
end
