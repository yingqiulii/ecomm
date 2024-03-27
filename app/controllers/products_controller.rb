# class ProductsController < ApplicationController
#   def show
#     @product= Product.find(params[:id])


#     @products = Product.all

#     if params[:keyword].present?
#       @products = @products.where("name LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
#     end

#     if params[:category_id].present?
#       @products = @products.where(category_id: params[:category_id])
#     end

#     @products = @products.page(params[:page]).per(5) # 假设你使用Kaminari进行分页
#   end

# end
class ProductsController < ApplicationController
  # 显示单个产品的详情
  def show
    @product = Product.find(params[:id])
  end

  # 显示产品列表或基于搜索条件的产品
  def index
    @products = if params[:keyword].present? || params[:category_id].present?
                  keyword = "%#{params[:keyword]}%"
                  products = Product.all
                  products = products.where("name LIKE ? OR description LIKE ?", keyword, keyword) if params[:keyword].present?
                  products = products.where(category_id: params[:category_id]) if params[:category_id].present?
                  products
                else
                  Product.all
                end
    @products = @products.page(params[:page]).per(5) # 使用Kaminari进行分页
  end
end
