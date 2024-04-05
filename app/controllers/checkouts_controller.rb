class CheckoutsController < ApplicationController
  def confirm
    province = params[:province]
    address = params[:address]
    name = params[:name]

    # 计算总价和税费
    total, tax = calculate_total_and_tax(province)

    # 创建或更新顾客信息
    customer = Customer.find_or_create_by(name: name, address: address, province: province)

    # 创建订单，包括税费信息
    order = create_order(customer, total, tax)

    # 响应，可能是重定向到订单确认页面或显示订单详情
    redirect_to order_path(order)
  end

  private

  def calculate_total_and_tax(province)
    # 假设这里有一个方法来计算购物车的总价，不包括税
    total_before_tax = calculate_total_before_tax
    tax = calculate_tax(province, total_before_tax)
    [total_before_tax, tax]
  end

  def calculate_total_before_tax
    # 示例逻辑：计算购物车商品的总价
    100 # 这里应根据实际情况来计算购物车内商品的总价
  end

  def calculate_tax(province, total_before_tax)
    case province
    when 'Alberta'
      total_before_tax * 0.05 # 只有GST
    when 'British Columbia'
      total_before_tax * 0.12 # GST+PST
    when 'Manitoba'
      total_before_tax * 0.12 # GST+PST
    when 'New Brunswick'
      total_before_tax * 0.15 # HST
    when 'Newfoundland and Labrador'
      total_before_tax * 0.15 # HST
    when 'Northwest Territories'
      total_before_tax * 0.05 # 只有GST
    when 'Nova Scotia'
      total_before_tax * 0.15 # HST
    when 'Nunavut'
      total_before_tax * 0.05 # 只有GST
    when 'Ontario'
      total_before_tax * 0.13 # HST
    when 'Prince Edward Island'
      total_before_tax * 0.15 # HST
    when 'Quebec'
      total_before_tax * 0.14975 # GST+QST
    when 'Saskatchewan'
      total_before_tax * 0.11 # GST+PST
    when 'Yukon'
      total_before_tax * 0.05 # 只有GST
    else
      0 # 如果省份不匹配，则没有税
    end
  end


  def create_order(customer, total, tax)
    # 创建订单，假设Order模型中已经有了处理税费的字段
    Order.create(customer_id: customer.id, total: total, tax: tax)
  end
end
