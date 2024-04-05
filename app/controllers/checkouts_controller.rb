class CheckoutsController < ApplicationController
  def confirm
    province = params[:province]
    address = params[:address]
    name = params[:name]

    customer = Customer.find_or_create_by(name: name, address: address, province: province)
    order = create_order(customer)
    redirect_to order_path(order)
  end

  private
  def create_order(customer)
    order = Order.create(customer: customer)
    @cart.cart_items.each do |item|
      order.order_items.create(
        product: item.product,
        quantity: item.quantity,
        price: item.product.price
      )
    end
    order.save
    order
  end


end


