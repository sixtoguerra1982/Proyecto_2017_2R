class MenusController < ApplicationController
  before_action :authenticate_user!
  before_action :check_role
  before_action :set_cook, only: [:new, :edit, :update, :create, :carousel, :index]
  before_action :set_menu, only: [:edit, :update, :destroy, :update_date]
  before_action :set_menus, only: [:new, :edit]

  # GET /menus
  # GET /menus.json
  def index
     @foco = params[:foco]
     @fecha = Date.today
     if params[:query] == "all"
       # query stream todos los menus
       @menus = @cook.menus.order(date: :desc).order(:name)
     else
       case params[:format]
         when 'left'
           # los dias dirente a hoy
           @menus = @cook.menus.where("menus.date != ?", Date.today).order(date: :asc).order(:name)
           @fecha = Date.today - 1.days
         when 'to_day'
           # OK hoy
           @menus = @cook.menus.where("menus.date = ? and menus.stock > 0", Date.today).order(stock: :desc).order(:name)
         when 'right'
           # dias igual a hoy y stock cero
           @menus = @cook.menus.where("menus.date = ? and menus.stock = 0", Date.today).order(:name)
         else
           if params[:datetimep1].present?
             str = params[:datetimep1]
             @menus = @cook.menus.where("menus.date = ?", str.to_date).order(:name)
           else
             if params[:foco].present?
               # edicion de stock y posicion de autofocus
               @menu = Menu.find(params[:foco])
               if @menu.stock > 0
                 @menus = @cook.menus.where("menus.date = ? and menus.stock > 0", Date.today).order(stock: :desc).order(:name)
               else
                 @menus = @cook.menus.where("menus.date = ? and menus.stock = 0", Date.today).order(:name)
               end
             else
               @menus = @cook.menus.where("menus.date = ? and menus.stock > 0", Date.today).order(stock: :desc).order(:name)
            end
          end
       end
    end
  end


  def carousel
    @menus = @cook.menus.order(:name)
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
    @menus = Menu.where(cook_id: @cook.id)
    @menu = Menu.new(menu_params)
    @menu.cook_id = @cook.id
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
      if @menu.update(menu_params)
        if params[:commit] == "GUARDAR"
          format.html { redirect_to menus_path(:foco => @menu.id), notice: 'El Menú fue actualizado' }
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
      @menu.stock = 0 if @menu.date.strftime("%Y%m%d") != Time.now.strftime("%Y%m%d")
      @menu.date = Date.today
      @menu.save
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
      @cook = Cook.find_by(user_id: current_user.id)
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
