
class CooksController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_cook, only: [:show, :edit, :update]
  before_action :check_role, only: [:edit, :update]


  def show
    @menus = @cook.menus.where("menus.date = ? and menus.stock > 0", Date.today).order(:name)
    @comment = Comment.new
    # suma de ordenes
    if user_signed_in?
      @orders = current_user.orders.where("date = ?", Date.today)
      @total = @orders.pluck("price * quantity").sum()
    end

  end

  def edit
  end

  def update
    respond_to do |format|
      @cook.address_region = params[:list_address_region]
      @cook.address_city = params[:list_address_city]
      @cook.address_commune = params[:list_address_commune]
      if @cook.update(cook_params)
        format.html { redirect_to menus_path, notice: 'Datos actualizados' }
        format.json { render :show, status: :ok, location: @cook }
      else
        format.html { render :edit }
        format.json { render json:@cook.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def cook_params
      params.require(:cook).permit(
      :name, :email, :phone, :biography, :address, :picture,
      :address_region, :address_commune, :address_city)
    end

    def set_cook
      @cook = Cook.find(params[:id])
    end

    def check_role
      if current_user.cook? == false or @cook.user_id != current_user.id
        redirect_to root_path
      end
    end
end
