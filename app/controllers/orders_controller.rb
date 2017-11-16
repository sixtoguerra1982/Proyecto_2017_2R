class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @menu = Menu.find(params[:menu_id])
    @order = Order.new(menu: @menu, user: current_user)
    if @order.save
      redirect_to menu_orders_path, notice: 'La orden ha sido ingresada'
    else
      redirect_to root_path, alert: 'La orden NO ha sido ingresada'
    end
  end

  def index
    @orders = current_user.orders
  end
end
