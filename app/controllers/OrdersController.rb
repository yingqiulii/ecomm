class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    # 假设Order模型有关联到OrderItems和Customer，你可以在这里预加载这些关联数据
  end
end
