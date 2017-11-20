class MenusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cook, only: [:new, :edit, :create, :index]
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  before_action :set_menus, only: [:new, :edit]
  
  # GET /menus
  # GET /menus.json
  def index
    ##chequear si el usuario es cocinero
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
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
        format.html { redirect_to edit_menu_path(@menu), notice: 'El Menú fue creado' }
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
      if @menu.update(menu_params)
        format.html { redirect_to edit_menu_path(@menu), notice: 'El Menú fue actualizado' }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
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
      @menu = Menu.find(params[:id])
    end

    def set_menus
      @menus = current_user.menus
    end

    def set_cook
      @cook = Cook.where(user_id: current_user.id)
    end  
    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :description, :picture, :price, :date)
    end	
end
