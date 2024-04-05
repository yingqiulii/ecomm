class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "tax", "total", "updated_at"]
  end

  before_save :calculate_total_and_tax

  private

  def calculate_total_and_tax
    self.total = order_items.sum { |item| item.price * item.quantity }
    tax_rate = tax_rate_for_province
    self.tax = self.total * tax_rate
  end


  def tax_rate_for_province
    tax_rates = {
      'AB' => 0.05, 'BC' => 0.12, 'MB' => 0.12, 'NB' => 0.15,
  'NL' => 0.15, 'NT' => 0.05, 'NS' => 0.15, 'NU' => 0.05,
  'ON' => 0.13, 'PE' => 0.15, 'QC' => 0.14975, 'SK' => 0.11,
  'YT' => 0.05
    }
    tax_rates[customer.province] || 0.0
  end
end
