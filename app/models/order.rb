class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

  validates :customer_id, presence: true, numericality: true

  # before_save :calculate_total_and_tax

  attribute :total, :decimal, default: 0.0
  attribute :tax, :decimal, default: 0.0

  private

  def calculate_total_and_tax
    self.total = order_items.inject(0) { |sum, item| sum + item.quantity * item.product.price }
    self.tax = self.total * tax_rate_for_province
  end

  def tax_rate_for_province
    # 建议将税率存储在一个配置文件或数据库中，以下为硬编码示例
    tax_rates = {
      'AB' => 0.05, 'BC' => 0.12, 'MB' => 0.12, 'New Brunswick' => 0.15,
      'Newfoundland and Labrador' => 0.15, 'Northwest Territories' => 0.05,
      'Nova Scotia' => 0.15, 'Nunavut' => 0.05, 'Ontario' => 0.13,
      'Prince Edward Island' => 0.15, 'Quebec' => 0.14975, 'Saskatchewan' => 0.11,
      'Yukon' => 0.05
    }
    tax_rates[customer.province] || 0.0
  end
end
