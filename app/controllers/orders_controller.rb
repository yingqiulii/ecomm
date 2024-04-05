class OrdersController < ApplicationController
    def show
      @order = Order.includes(:customer, :order_items).find(params[:id])
      @taxes = calculate_taxes(@order)
    end

  private

  def calculate_taxes(order)
    province = order.customer.province
    total = order.total

    {name:province,amount:total}
  end
end

