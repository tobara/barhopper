class BarsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user!, only: [:edit, :update]
  before_action :authorize_admin!, only: [:destroy]

  def upvote
    @bar = Bar.find(params[:id])
    @bar.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @bar = Bar.find(params[:id])
    @bar.downvote_by current_user
    redirect_to :back
  end

  def index
    @bars = Bar.page(params[:page])
    Bar.popular_times(@bars)
    time = Time.new
    @day = time.strftime('%A')+"\'s"
    @hour = time.strftime('%I-%p')
    @hour_now = Time.now.strftime("%H")
    @day_now = Time.now.strftime("%A")
  end

  def show
    @bar = Bar.find(params[:id])
    @comments = @bar.comments
    @bar_rating = Comment.rating(@comments)
  end

  def new
    @bar = Bar.new
  end

  def edit
    @bar = Bar.find(params[:id])
  end

  def create
    @bar = Bar.new(bar_params)
    @bar.user = current_user
    create_query
    if @bar.save
      flash[:notice] = "BAR added successfully"
      redirect_to bar_path(@bar)
    else
      flash.now[:errors] = @bar.errors.full_messages.join(". ")
      render :new
    end
  end

  def create_query
    @query = "http://www.google.com/search?q="
    @query << "#{@bar.name}+#{@bar.location}&num=10"
    @bar.popular_query = @query.gsub!(/\s+/, "+")
  end

  def update
    @bar = Bar.find(params[:id])

    if @bar.update_attributes(bar_params)
      flash[:notice] = 'BAR updated successfully'
      redirect_to bar_path(@bar)
    else
      flash.now[:error] = @bar.errors.full_messages.join(". ")
      render :edit
    end
  end

  private

  def bar_params
    params.require(:bar).permit(
      :name, :location, :address)
  end

  def authorize_user!
    user = Bar.find(params[:id]).user
    unless current_user == user || current_user.admin?
      flash[:alert] = "You Are Not Authorized To View The Page"
      redirect_to after_sign_in_path_for(current_user)
    end
  end
end
