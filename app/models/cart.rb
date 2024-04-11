class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  belongs_to :customer
  def total
    cart_items.to_a.sum{|cart_item| cart_item.total}
  end
end
