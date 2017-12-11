
class CooksController < ApplicationController
	before_action :set_cook, only: [:show, :edit, :update]

	def show
	  	@menus = @cook.menus
			@comment = Comment.new
	end

	def edit
	end

	def update
		respond_to do |format|
			if @cook.update(cook_params)
				@cook.address_region = params[:list_address_region]
				@cook.address_city = params[:list_address_city]
				@cook.address_commune = params[:list_address_commune]
				byebug
				@cook.save
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
end
