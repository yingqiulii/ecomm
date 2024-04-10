class Customer < ApplicationRecord
  has_many :orders
  def self.ransackable_attributes(auth_object = nil)
    ["address", "city", "created_at", "email", "id", "id_value", "name", "phone", "postal_code", "province", "updated_at"]
  end

#   attr_accessor :password, :password_confirmation

#   validates_presence_of :email, message: "put email"
#   validates :email, uniqueness: true

#   validates_presence_of :password, message: "put password",
#     if: :need_validate_password
#   validates_presence_of :password_confirmation, message: "put",
#   if: :need_validate_password
#   validates_confirmation_of :password, message: "not match",
#   if: :need_validate_password
# private
# def need_validate_password
#   self.new_record? ||
#   (!self.password.nil?|| !self.password_confirmation.nil?)
# end

devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
