class CommentsController < ApplicationController
  def create
    @cook = Cook.find(params[:cook_id])
    @comment = Comment.new(content: params[:comment][:content], user: current_user)
    @cook.comments << @comment
    @comment.save
    redirect_to menu_show_path(@cook)
	end

	def destroy
		@cook = Cook.find(params[:cook_id])
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to @cook
	end
end
