# class HomeController < ApplicationController
#   def index
#     @main_categories = Category.take(4)
#   end
#   def index
#     @products = Product.all
#   end
#   def index
#     @main_categories = Category.all # or any specific logic to fetch categories
#   end
# end
class HomeController < ApplicationController
  def index
    # Fetches the first 4 categories. You might adjust this based on your needs.
    @main_categories = Category.limit(4)

    # Fetches all products. Consider applying limits or pagination if there are many products.
    @products = Product.all

  end
end
