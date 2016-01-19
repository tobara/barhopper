class BarsController < ApplicationController
  def index
    @bars = Bar.page(params[:page])
  end

  def show
    @bar = Bar.find(params[:id])
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
end  