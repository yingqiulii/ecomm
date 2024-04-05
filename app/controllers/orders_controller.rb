class OrdersController < ApplicationController
    def show
      @order = Order.includes(:customer, :order_items).find(params[:id])
      @taxes = calculate_taxes(@order)
    end

  private

  # def calculate_taxes(order)
  #   province = order.customer.province
  #   total =order.tax
  #   {name:province,amount:total}
  # end
  def calculate_taxes(province, subtotal)
    tax_info = TAX_RATES[province]

    if tax_info.nil?
      return { gst: 0, pst: 0, hst: 0, total_tax: 0 }
    end

    gst_amount = subtotal * tax_info[:gst]
    pst_amount = subtotal * tax_info[:pst]
    hst_amount = subtotal * tax_info[:hst]
    total_tax = gst_amount + pst_amount + hst_amount

    { gst: gst_amount, pst: pst_amount, hst: hst_amount, total_tax: total_tax }
  end

end

