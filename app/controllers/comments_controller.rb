class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy, :show]
  before_action :set_cook
  before_action :authenticate_user!

  # POST /comments
  # POST /comments.json
  def show
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.cook = @cook

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.cook, notice: 'Comment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to menu_show_path(@cook), notice: 'Comment was successfully updated.' }
        format.json { render :menu_show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @cook, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_cook
    @cook = Cook.find(params[:cook_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:content, :rating, :user_id, :cook_id)
  end
end
