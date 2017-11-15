
class CooksController < ApplicationController
	  
	  def menu_show
	  	@cook = Cook.find(params[:id])
	  	@menus = @cook.menus
	  end

	private
	 	def menu_params
	 		params.require(:cook).permit(:name, :description, :picture, :price, :cook_id, :date)
	 	end
end