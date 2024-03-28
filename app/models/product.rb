class Product < ApplicationRecord
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [50, 50]
    attachable.variant :medium, resize_to_limit: [250, 250]
  end
  belongs_to :category
  has_one_attached :image
  has_many :cart_items
  has_many :carts, through: :cart_items

  def self.ransackable_associations(auth_object = nil)
    ['category']
  end
  def self.ransackable_attributes(auth_object = nil)
    ['name', 'description', 'price', 'category_id']
  end

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: true
  validates :category_id, presence: true
end
