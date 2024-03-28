class Customer < ApplicationRecord
  has_many :orders

  validates :name, presence: true

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :address, presence: true

  validates :registration_date, presence: true, timeliness: { type: :date }

end
