class BarsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user!, only: [:edit, :update]
  before_action :authorize_admin!, only: [:destroy]

  def index
    @bars = Bar.page(params[:page])
  end

  def show
    @bar = Bar.find(params[:id])
    @comments = @bar.comments
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

    if @bar.save
      flash[:notice] = "BAR added successfully"
      redirect_to bar_path(@bar)
    else
      flash.now[:errors] = @bar.errors.full_messages.join(". ")
      render :new
    end
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
