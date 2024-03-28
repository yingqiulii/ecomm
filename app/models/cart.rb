class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  validates :cart_items, presence: true
  validates :total, numericality: true
  def total
    cart_items.to_a.sum{|cart_item| cart_item.total}
  end
end
