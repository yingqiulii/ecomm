class Customer < ApplicationRecord
  has_many :orders
  def self.ransackable_attributes(auth_object = nil)
    ["address", "city", "created_at", "email", "id", "id_value", "name", "phone", "postal_code", "province", "updated_at"]
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
