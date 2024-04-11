# class CheckoutsController < ApplicationController
#   def confirm
#     province = params[:province]
#     address = params[:address]
#     name = params[:name]

#     customer = Customer.find_or_create_by(name: name, address: address, province: province)
#     order = create_order(customer)
#     redirect_to order_path(order)
#   end

#   private
#   def create_order(customer)
#     order = Order.create(customer: customer)
#     @cart.cart_items.each do |item|
#       order.order_items.create(
#         product: item.product,
#         quantity: item.quantity,
#         price: item.product.price
#       )
#     end
#     order.save
#     order
#   end
# end


class CheckoutsController < ApplicationController
  # def confirm
  #   # 根据情况创建或找到顾客
  #   if customer_signed_in?
  #     customer = current_customer
  #   else
  #     name = params[:name]
  #     address = params[:address]
  #     province = params[:province]
  #     customer = Customer.find_or_create_by(name: name, address: address, province: province)
  #   end

  #   # 创建订单
  #   order = create_order(customer)

  #   # 根据创建结果重定向或渲染视图
  #   if order.persisted?
  #     redirect_to order_path(order), notice: "Order was successfully created."
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end
  def confirm
    # 使用表单提交的信息更新当前用户的信息，或者为未登录的用户创建新的Customer记录
    customer = update_or_create_customer

    # 创建订单
    order = create_order(customer)

    # 根据创建结果重定向或渲染视图
    if order.persisted?
      redirect_to order_path(order), notice: "Order was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def update_or_create_customer
    if customer_signed_in?
      current_customer.update(customer_params)
      current_customer
    else
      Customer.create(customer_params)
    end
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

  def customer_signed_in?
    !current_customer.nil?
  end
end
