# class Order < ApplicationRecord
#   belongs_to :customer
#   has_many :order_items, dependent: :destroy

#   def self.ransackable_associations(auth_object = nil)
#     ["customer", "order_items"]
#   end
#   def self.ransackable_attributes(auth_object = nil)
#     ["created_at", "customer_id", "id", "tax", "total", "updated_at"]
#   end

#   before_save :calculate_total_and_tax

#   private

#   def calculate_total_and_tax
#     self.total = order_items.sum { |item| item.price * item.quantity }
#     tax_rate = tax_rate_for_province
#     self.tax = self.total * tax_rate
#   end


#   def tax_rate_for_province
#     tax_rates = {
#       'AB' => 0.05, 'BC' => 0.12, 'MB' => 0.12, 'NB' => 0.15,
#   'NL' => 0.15, 'NT' => 0.05, 'NS' => 0.15, 'NU' => 0.05,
#   'ON' => 0.13, 'PE' => 0.15, 'QC' => 0.14975, 'SK' => 0.11,
#   'YT' => 0.05
#     }
#     tax_rates[customer.province] || 0.0
#   end
# end

class Order < ApplicationRecord
  belongs_to :customer
  before_save :update_province_and_address
  has_many :order_items, dependent: :destroy
    def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "tax", "total", "updated_at"]
  end
  before_save :calculate_total_and_tax


  def tax_details
    tax_info = tax_rate_for_province
    subtotal = order_items.sum { |item| item.price * item.quantity }

    gst_amount = subtotal * tax_info[:gst]
    pst_amount = subtotal * tax_info[:pst]
    hst_amount = subtotal * tax_info[:hst]
    total_tax = gst_amount + pst_amount + hst_amount

    { gst: gst_amount, pst: pst_amount, hst: hst_amount, total_tax: total_tax }
  end

  private

  def calculate_total_and_tax
    self.total = order_items.sum { |item| item.price * item.quantity }
    tax_info = tax_rate_for_province

    # 根据省份税率信息计算税费
    gst_amount = self.total * tax_info[:gst]
    pst_amount = self.total * tax_info[:pst]
    hst_amount = self.total * tax_info[:hst]

    # 如果省份使用HST，则只应用HST；否则，应用GST和PST
    total_tax = hst_amount > 0 ? hst_amount : (gst_amount + pst_amount)

    # 更新订单税费和含税总额
    self.tax = total_tax
    self.total += total_tax
  end

  def tax_rate_for_province
    tax_rates = {

  'AB' => { gst: 0.05, pst: 0.0, hst: 0.0 },   # 阿尔伯塔省
  'BC' => { gst: 0.05, pst: 0.07, hst: 0.0 },  # 不列出HST的省份需要分别列出GST和PST
  'MB' => { gst: 0.05, pst: 0.07, hst: 0.0 },  # 曼尼托巴省
  'NB' => { gst: 0.0, pst: 0.0, hst: 0.15 },   # 新不伦瑞克省
  'NL' => { gst: 0.0, pst: 0.0, hst: 0.15 },   # 纽芬兰与拉布拉多省
  'NT' => { gst: 0.05, pst: 0.0, hst: 0.0 },   # 西北地区
  'NS' => { gst: 0.0, pst: 0.0, hst: 0.15 },   # 新斯科舍省
  'NU' => { gst: 0.05, pst: 0.0, hst: 0.0 },   # 努纳武特
  'ON' => { gst: 0.0, pst: 0.0, hst: 0.13 },   # 安大略省
  'PE' => { gst: 0.0, pst: 0.0, hst: 0.15 },   # 爱德华王子岛
  'QC' => { gst: 0.05, pst: 0.09975, hst: 0.0 }, # 魁北克省
  'SK' => { gst: 0.05, pst: 0.06, hst: 0.0 },  # 萨斯喀彻温省
  'YT' => { gst: 0.05, pst: 0.0, hst: 0.0 },   # 育空地区
    }
    tax_rates[customer.province] || { gst: 0.0, pst: 0.0, hst: 0.0 }
  end

  private

  def update_province_and_address
    self.province = customer.province if customer.present?
    self.address = customer.address if customer.present?
  end
end
