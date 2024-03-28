class CheckoutsController < ApplicationController
  before_action :set_cart

  def show
    @customer = Customer.new
    @order = Order.new
    @cart = current_cart
  end

  def create
    ActiveRecord::Base.transaction do
      @customer = Customer.find_or_initialize_by(email: customer_params[:email])
      @customer.assign_attributes(customer_params)
      @customer.save!

      @order = @customer.orders.create!(order_params.merge(total: calculate_total(@cart, @customer.province)))

      @cart.cart_items.each do |item|
        @order.order_items.create!(product: item.product, quantity: item.quantity, price: item.product.price)
      end

      session[:cart_id] = nil # 清空当前购物车
    end

    redirect_to root_path, notice: 'Order has been placed successfully.'
  rescue => e
    flash.now[:alert] = e.message
    render :show
  end

  private

  def set_cart
    @cart = current_cart
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :address, :province)
  end

  def order_params
    params.require(:order).permit(:payment_method)
  end

  def calculate_total(cart, province)
    subtotal = cart.cart_items.sum { |item| item.quantity * item.product.price }
    tax_rate = tax_rate_for_province(province)
    subtotal * (1 + tax_rate)
  end

  def tax_rate_for_province(province)
    # 根据省份返回相应的税率
    case province
    when 'Ontario'
      0.13 # HST
    when 'British Columbia'
      0.12 # GST + PST
    # 添加其他省份和税率
    else
      0.05 # 默认GST
    end
  end

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
