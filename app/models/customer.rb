class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  has_one :cart
  def self.ransackable_attributes(auth_object = nil)
    ["address", "city", "created_at", "email", "id", "id_value", "name", "phone", "postal_code", "province", "updated_at"]
  end
  pay_customer stripe_attributes: :stripe_attributes

def stripe_attributes(pay_customer)
  {
    address: {
      city: pay_customer.owner.city,
      state: pay_customer.owner.province
    },
    metadata: {
      pay_customer_id: pay_customer.id,
      customer_id:id
    }
  }
end
end
