class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

  validates :customer_id, presence: true, numericality: true

  before_save :calculate_total_and_tax

  attribute :total, :decimal, default: 0.0
  attribute :tax, :decimal, default: 0.0

  private

  def calculate_total_and_tax
    self.total = order_items.sum { |item| item.price * item.quantity }
    tax_rate = tax_rate_for_province # 确保这里是你的税率获取方法
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
