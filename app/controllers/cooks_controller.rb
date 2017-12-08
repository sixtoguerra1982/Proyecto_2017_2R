
class CooksController < ApplicationController
	before_action :set_cook, only: [:show, :update, :destroy]

	def show
	  	@menus = @cook.menus
			@comment = Comment.new
	end

	def edit
		@cook = Cook.where(user_id: current_user, cook: true)
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
