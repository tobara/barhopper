class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [
    :new, :create, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def new
    @bar = Bar.find(params[:bar_id])
    @user = current_user
    @comment = Comment.new
  end

  def edit
    @bar = Bar.find(params[:bar_id])
    @user = current_user
    @comment = Comment.find(params[:id])
  end

  def create
    @bar = Bar.find(params[:bar_id])
    @user = current_user
    @comment = @bar.comments.new(comment_params)
    @comment.user = @user
    if @comment.save
      flash[:notice] = "Comment added successfully"
      redirect_to bar_path(@bar)
    else
      flash.now[:errors] = @comment.errors.full_messages.join(". ")
      render :new
    end
  end

  def update
    @bar = Bar.find(params[:bar_id])
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)

    if @comment.save
      flash[:notice] = 'Comment updated successfully'
      redirect_to bar_path(@comment.bar)
    else
      flash.now[:error] = @comment.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    bar = @comment.bar
    @comment.destroy

    redirect_to bar_path(bar), notice: "Comment Destroyed!"
  end

  private

  def comment_params
    params.require(:comment).permit(:description, :rating, :user, :bar)
  end

  def authorize_user!
    user = Comment.find(params[:id]).user
    unless current_user == user || current_user.admin?
      flash[:alert] = "You Are Not Authorized To View The Page"
      redirect_to after_sign_in_path_for(current_user)
    end
  end
end
