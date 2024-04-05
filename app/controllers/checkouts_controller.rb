# class CheckoutsController < ApplicationController
#   def confirm
#     province = params[:province]
#     address = params[:address]
#     name = params[:name]

#     # 计算总价和税费
#     total, tax = calculate_total_and_tax(province)

#     # 创建或更新顾客信息
#     customer = Customer.find_or_create_by(name: name, address: address, province: province)

#     # 创建订单，包括税费信息
#     order = create_order(customer, total, tax)

#     # 响应，可能是重定向到订单确认页面或显示订单详情
#     redirect_to order_path(order)
#   end

#   private

#   def calculate_total_and_tax(province)
#     # 假设这里有一个方法来计算购物车的总价，不包括税
#     total_before_tax = calculate_total_before_tax
#     tax = calculate_tax(province, total_before_tax)
#     [total_before_tax, tax]
#   end

#   def calculate_total_before_tax
#     total_before_tax = @cart.cart_items.inject(0) do |total, item|
#       total + item.quantity * item.product.price
#     end
#     total_before_tax
#   end


#   def calculate_tax(province, total_before_tax)
#     case province
#     when 'AB'
#       total_before_tax * 0.05 # 只有GST
#     when 'BC'
#       total_before_tax * 0.12 # GST+PST
#     when 'MB'
#       total_before_tax * 0.12 # GST+PST
#     when 'New Brunswick'
#       total_before_tax * 0.15 # HST
#     when 'Newfoundland and Labrador'
#       total_before_tax * 0.15 # HST
#     when 'Northwest Territories'
#       total_before_tax * 0.05 # 只有GST
#     when 'Nova Scotia'
#       total_before_tax * 0.15 # HST
#     when 'Nunavut'
#       total_before_tax * 0.05 # 只有GST
#     when 'Ontario'
#       total_before_tax * 0.13 # HST
#     when 'Prince Edward Island'
#       total_before_tax * 0.15 # HST
#     when 'Quebec'
#       total_before_tax * 0.14975 # GST+QST
#     when 'Saskatchewan'
#       total_before_tax * 0.11 # GST+PST
#     when 'Yukon'
#       total_before_tax * 0.05 # 只有GST
#     else
#       0 # 如果省份不匹配，则没有税
#     end
#   end


#   def create_order(customer, total, tax)
#     # 创建订单，假设Order模型中已经有了处理税费的字段
#     Order.create(customer_id: customer.id, total: total, tax: tax)
#   end
# end
class CheckoutsController < ApplicationController
  def confirm
    province = params[:province]
    address = params[:address]
    name = params[:name]

    # 创建或更新顾客信息
    customer = Customer.find_or_create_by(name: name, address: address, province: province)

    # 假设有一个方法来创建订单，这个方法内部会触发模型的 before_save 回调来计算总价和税费
    order = create_order(customer)

    # 响应，可能是重定向到订单确认页面或显示订单详情
    redirect_to order_path(order)
  end

  private

  def create_order(customer)
    order = Order.create(customer: customer)
    @cart.cart_items.each do |item|
      order.order_items.create(
        product: item.product,
        quantity: item.quantity,
        price: item.product.price # 确保这里正确设置了价格
      )
    end
    order
  end

end
