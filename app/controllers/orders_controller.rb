# class OrdersController < ApplicationController
#     def show
#       @order = Order.includes(:customer, :order_items).find(params[:id])
#       @taxes = calculate_taxes(@order)
#     end

#   private

#   def calculate_taxes(order)
#     province = order.customer.province
#     total =order.tax
#     {name:province,amount:total}
#   end
# end

class OrdersController < ApplicationController
  def show
    @order = Order.includes(:customer, :order_items).find(params[:id])
    @taxes = @order.tax_details
    @render_cart = false
end
end