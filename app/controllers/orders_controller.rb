class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_orders, only: [:index, :create, :to_buy]

  def index
    @total = @orders.pluck("price * quantity").sum()
    @cook = Menu.find(@orders.first.menu_id).cook if @orders.count > 0
  end

  def create

    @menu = Menu.find(params[:menu_id]) #Menu seleccionado
    id_cook_seleccionado = @menu.cook.id #id menu_seleccionado

    @order = Order.where(user: current_user, payed: false, date: Date.today).first
    unless @order.nil?
      id_cook_seleccionado_order = Menu.find(@order.menu_id).cook.id
    end
    if id_cook_seleccionado_order == id_cook_seleccionado or @order.nil?

      m = @menu.orders.where(user_id: current_user, payed: false , date: Date.today).count

      if m > 0
         o = Order.where(user: current_user, payed: false, date: Date.today, menu_id: @menu.id).first
         o.quantity = o.quantity + 1
         o.save
      else
        @order = Order.new(menu: @menu, user: current_user,
                          price: @menu.price, date: Date.today,
                          request_description: @menu.name)
        @order.quantity = 1
        @order.save
      end
    else
      @notice = "Tiene una orden pendiente con otro cocinero !!!!"
    end
    # suma de ordenes
    @total = @orders.pluck("price * quantity").sum()
  end

  def clean
    @orders = Order.where(user: current_user, payed: false)
    @orders.destroy_all
    redirect_to orders_path, notice: 'El carro se ha vaciado.'
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_path, notice: 'La orden ha sido Eliminado !!!' }
      format.json { head :no_content }
    end
  end

  def to_buy


    @ubicacion = HeaderOrder.find_by(user_id: current_user,
                date: Date.today, payed: false)

    unless @ubicacion.nil?
      @ubicacion = @ubicacion.payment_address
    end


    @total = @orders.pluck("price * quantity").sum()
  end

  private
    def set_orders
      @orders = current_user.orders.where(payed: false, date: Date.today)
    end
end
