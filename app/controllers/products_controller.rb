
class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end


  # def index
  #   @products = Product.all

  #   if params[:keyword].present?
  #     keyword = "%#{params[:keyword]}%"
  #     @products = @products.where("name LIKE ? OR description LIKE ?", keyword, keyword)
  #   end

  #   if params[:category_id].present?
  #     @products = @products.where(category_id: params[:category_id])
  #   end

  #   @products = @products.page(params[:page]).per(5)
  # end
  def index
    @products = Product.all

    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @products = @products.where("name LIKE ?", keyword)
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    @products = @products.page(params[:page]).per(5)
  end

end
