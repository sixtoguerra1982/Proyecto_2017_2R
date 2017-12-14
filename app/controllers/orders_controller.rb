class OrdersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_order

  def index
    @orders = current_user.orders
    @total = @orders.pluck("price * quantity").sum()
    @cook = Menu.find(@orders.first.menu_id).cook unless @orders.nil?
  end

  def create
    @menu = Menu.find(params[:menu_id]) #Menu seleccionado
    id_cook_seleccionado = @menu.cook.id #id menu_seleccionado
    @order = Order.where(user: current_user, payed: false, date: Date.today).first
    unless @order.nil?
      id_cook_seleccionado_order = Menu.find(@order.menu_id).cook.id
    end
    if id_cook_seleccionado_order == id_cook_seleccionado or @order.nil?
      @order = Order.new(menu: @menu, user: current_user,
                        price: @menu.price, date: Date.today,
                        request_description: @menu.name)
      @order.quantity = 1
      @order.save
    else
      @notice = "Tiene una orden pendiente con otro cocinero !!!!"
    end
    # end
    #
    # suma de ordenes
    @orders = current_user.orders.where("date = ?", Date.today)
    @total = @orders.pluck("price * quantity").sum()
  end

  def clean
    @orders = Order.where(user: current_user, payed: false)
    @orders.destroy_all
    redirect_to orders_path, notice: 'El carro se ha vaciado.'
  end

  private
    def set_order
      @order
    end
end
