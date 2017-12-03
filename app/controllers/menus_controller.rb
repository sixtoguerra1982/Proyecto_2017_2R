class MenusController < ApplicationController
  before_action :authenticate_user!
  before_action :check_role
  before_action :set_cook, only: [:new, :edit, :create, :index, :carousel]
  before_action :set_menu, only: [:show, :edit, :update, :destroy, :update_date]
  before_action :set_menus, only: [:new, :edit]

  # GET /menus
  # GET /menus.json
  def index
    ##chequear si el usuario es cocinero
     if params[:q].present?
       @menus = @cook.first.menus
     else
       if params[:query] == "all"
         @menus = @cook.first.menus.order(date: :asc).order(stock: :desc).order(:name)
       else
         @menus = @cook.first.menus.where(date: Time.now).order(date: :asc).order(stock: :desc).order(:name)
      end
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  def carousel
    @menus = @cook.first.menus.order(:name)
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)
    @menu.cook_id = @cook.ids.first
    respond_to do |format|
      if @menu.save
        format.html { redirect_to new_menu_path, notice: 'El Menú fue creado' }
        format.json { render :show, status: :created, location: @menu }
      else
        format.html { render :new }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if params[:commit] == "EDITAR"
        # @menu.stock = 0
      end
      if @menu.update(menu_params)
        if params[:commit] == "GUARDAR"
          format.html { redirect_to menus_path, notice: 'El Menú fue actualizado' }
        else
          format.html { redirect_to new_menu_path, notice: 'El Stock fue actualizado' }
        end
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_date
    respond_to do |format|
      @menu.stock = 0 if @menu.date.strftime("%Y%m%d") != Time.now.strftime("%Y%m%d")
      @menu.date = Time.now
      if @menu.save
        format.html { redirect_to menus_path, notice: 'El Menú fue actualizado' }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    @menu.remove_picture!
    respond_to do |format|
      format.html { redirect_to new_menu_path, notice: 'El Menú ha sido Eliminado !!!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      if params[:id]
        @menu = Menu.find(params[:id])
      else
        @menu =  Menu.find(params[:menu_id])
      end
    end
    def set_menus
      @menus = current_user.menus
    end
    def set_cook
      @cook = Cook.where(user_id: current_user.id)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :description, :picture, :price, :date, :stock)
    end

    #check role segun enum role: [:visit, :admin, :cook]

    def check_role
      if current_user.cook? == false
        redirect_to root_path
      end
    end
end
