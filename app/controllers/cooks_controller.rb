
class CooksController < ApplicationController
	before_action :set_cook, only: [:show, :edit]

	def show
	  	@menus = @cook.menus
			@comment = Comment.new
	end

	def edit

	end

	private
	 	def cook_params
	 		params.require(:cook).permit(
				:name, :email, :phone, :biography, :address, :picture)
	 	end

		def set_cook
			@cook = Cook.find(params[:id])
		end
end
