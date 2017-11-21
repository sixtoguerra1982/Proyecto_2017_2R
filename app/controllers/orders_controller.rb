class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @menu = Menu.find(params[:menu_id])
    @order = Order.new(menu: @menu, user: current_user, price: @menu.price)
    @order.quantity += 1
    if @order.save
      redirect_to menu_orders_path, notice: 'La orden ha sido ingresada'
    else
      redirect_to root_path, alert: 'La orden NO ha sido ingresada'
    end
  end

  def clean
    @orders = Order.where(user: current_user, payed: false)
    @orders.destroy_all
    redirect_to orders_path, notice: 'El carro se ha vaciado.'
  end

  def index
    @orders = current_user.orders
    @total = @orders.pluck("price * quantity").sum()
  end
end
