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

  def confirm
    @order = Order.new(order_params)
    # 如果用户已登录，关联当前用户
    @order.customer_id = current_customer.id if customer_signed_in?

    if @order.save
      # 处理订单成功的情况
      redirect_to order_path, notice: "Order was successfully created."
    else
      # 处理保存失败的情况，如重新渲染表单
      render :new, status: :unprocessable_entity
    end
  end

  private

  # 使用强参数确保安全，这里假设订单有一些基本属性
  def order_params
    params.require(:order).permit(:total, :tax, :province, :address)
  end

  # 如果你使用Devise并且你的用户模型是Customer
  def customer_signed_in?
    !current_customer.nil?
  end
end


