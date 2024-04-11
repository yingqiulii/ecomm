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


# class CheckoutsController < ApplicationController
#   def confirm
#     # 根据情况创建或找到顾客
#     if customer_signed_in?
#       customer = current_customer
#     else
#       name = params[:name]
#       address = params[:address]
#       province = params[:province]
#       customer = Customer.find_or_create_by(name: name, address: address, province: province)
#     end

#     # 创建订单
#     order = create_order(customer)

#     # 根据创建结果重定向或渲染视图
#     if order.persisted?
#       redirect_to order_path(order), notice: "Order was successfully created."
#     else
#       render :new, status: :unprocessable_entity
#     end
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


#   def customer_signed_in?
#     !current_customer.nil?
#   end
# end


class CheckoutsController < ApplicationController
  before_action :authenticate_customer!, only: [:confirm], unless: -> { request.format.js? }
def show
current_customer.set_payment_processor :stripe
current_customer.payment_processor.customer
@order = Order.find_by(id: params[:id])
  if @order.nil?
    redirect_to root_path
    return
  end
  line_items = @order.order_items.map do |item|
    {
      price_data: {
        currency: 'usd',
        product_data: {
          name: item.product.name,
          description: item.product.description
        },
        unit_amount: (item.price * 100).to_i
      },
      quantity: item.quantity
    }
  end


  # 创建Stripe checkout会话
  @checkout_session = current_customer.payment_processor.checkout(
    mode: 'payment',
    success_url: checkout_success_url,
    line_items: line_items
  )
end


  def success

  end
 
  def confirm
    # 创建或更新顾客信息
    customer = update_or_create_customer

    # 如果无法保存顾客信息（比如，验证失败），则停止执行并返回
    unless customer.persisted?
      flash[:error] = "There was a problem with your information: " + customer.errors.full_messages.join(", ")
      redirect_to new_order_path and return # 假设有一个用于显示表单的路径
    end

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
    customer_attrs = { name: params[:name], address: params[:address], province: params[:province] }
    if customer_signed_in?
      current_customer.update(customer_attrs)
      current_customer
    else
      Customer.find_or_create_by(customer_attrs)
    end
  end

  def create_order(customer)
    order = Order.new(customer: customer)
    @cart.cart_items.each do |item|
      order.order_items.build(
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
