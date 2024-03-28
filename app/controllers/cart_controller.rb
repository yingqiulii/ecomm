class CartController < ApplicationController
  def show
    @render_cart=false
  end

  def add
    @product=Product.find_by(id: params[:id])
    quantity=params[:quantity].to_i
    current_cart_item = @cart.cart_items.find_by(product_id: @product.id)
    # if current_cart_item && quantity > 0
    #   current_cart_item.update(quantity:)
    # elseif quantity<=0
    # current_cart_item.destroy
    # else
    #   @cart.cart_item.create(product:@product,quantity:)
    # end
    if current_cart_item && quantity > 0
      current_cart_item.update(quantity: quantity)
    elsif quantity <= 0
      current_cart_item.destroy
    else
      @cart.cart_items.create(product: @product, quantity: quantity)

    end
  end

  # def remove
  #   CartItem.find_by(id: params[:id].destroy)
  # end
  def remove
    cart_item = CartItem.find_by(id: params[:id])
    cart_item.destroy if cart_item.present?
    redirect_to cart_path, notice: 'Product removed from cart successfully.'
  end

end
