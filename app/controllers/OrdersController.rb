# class OrdersController < ApplicationController
#   # def show
#   #   @order = Order.includes(:customer, :order_items).find(params[:id])
#   #   @taxes = calculate_taxes(@order)
#   # end


#   private

#   def calculate_taxes(order)
#     province = order.customer.province
#     total = order.total

#     # 加拿大各省份和地区的税率，注意：这些税率可能会变，请根据最新情况更新
#     tax_rates = {
#       "AB" => { gst: 0.05, pst: 0.0, hst: 0.0 },
#       "BC" => { gst: 0.05, pst: 0.07, hst: 0.0 },
#       "MB" => { gst: 0.05, pst: 0.07, hst: 0.0 },
#       "New Brunswick" => { gst: 0.0, pst: 0.0, hst: 0.15 },
#       "Newfoundland and Labrador" => { gst: 0.0, pst: 0.0, hst: 0.15 },
#       "Northwest Territories" => { gst: 0.05, pst: 0.0, hst: 0.0 },
#       "Nova Scotia" => { gst: 0.0, pst: 0.0, hst: 0.15 },
#       "Nunavut" => { gst: 0.05, pst: 0.0, hst: 0.0 },
#       "Ontario" => { gst: 0.0, pst: 0.0, hst: 0.13 },
#       "Prince Edward Island" => { gst: 0.0, pst: 0.0, hst: 0.15 },
#       "Quebec" => { gst: 0.05, pst: 0.09975, hst: 0.0 },
#       "Saskatchewan" => { gst: 0.05, pst: 0.06, hst: 0.0 },
#       "Yukon" => { gst: 0.05, pst: 0.0, hst: 0.0 }
#     }

#     # 获取当前省份的税率，如果省份未知，则默认为0
#     rates = tax_rates[province] || { gst: 0.0, pst: 0.0, hst: 0.0 }

#     # 计算税费
#     gst = total * rates[:gst]
#     pst = total * rates[:pst]
#     hst = total * rates[:hst]

#     # 返回税费详情
#     { gst: gst, pst: pst, hst: hst }
#   end
# end
class OrdersController < ApplicationController
  def show
    @order = Order.includes(:customer, :order_items).find(params[:id])
  end
end
