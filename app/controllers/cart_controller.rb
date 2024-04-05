class CartController < ApplicationController
  def show
    @render_cart=false
  end

  def add
    @product=Product.find_by(id: params[:id])
    quantity=params[:quantity].to_i
    current_cart_item = @cart.cart_items.find_by(product_id: @product.id)
    if current_cart_item && quantity > 0
      current_cart_item.update(quantity: quantity)
    elsif quantity <= 0
      current_cart_item.destroy
    else
      @cart.cart_items.create(product: @product, quantity: quantity)
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart',
                                                   partial: 'cart/cart',
                                                   locals: { cart: @cart }),
                              ]
      end
    end
  end


  def remove
    cart_item = CartItem.find_by(id: params[:id])
    cart_item.destroy if cart_item.present?
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('cart',
                                                  partial: 'cart/cart_item',
                                                  locals: { cart: @cart })
      end
    end
  end

end
