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
    n = 0
    @bars.each do |bar|
      @bar_name = bar.name
      @bar_name += " #{bar.location}"
      @bar_name.gsub(" ","+")
      url = "http://www.google.com/search?q="+"#{@bar_name}"+"&num=10"
      agent = Mechanize.new { |agent| agent.user_agent_alias = "Mac Safari" }
      html = agent.get(url).body
      doc = Nokogiri::HTML(html)
      doc_string = doc.to_s
      doc_find = nil
      if result = doc_string.match(/lubh-bar( _...)/)
        doc_find = result.captures
        div_end = doc_find[0]
        div_find = "lubh-bar"+"#{div_end}"
        doc_at = doc.xpath("//div[@class=\"#{div_find}\"]")
      end
      if doc_at.nil?
        bar_pop = 0
      else
        doc_style = doc_at[0]["style"]
        bar_pop = doc_style.gsub(/[^0-9]/, '')
      end
      bar.attributes = { :popular_time => bar_pop }
      pop_value = bar.popular_time.to_i
      n += 1
      bar.attributes = { :bar_img => "bar#{n}" }
    end
      @time = Time.new
      @day = @time.strftime('%A')+"\'s"
      @hour = @time.strftime('%I-%p')
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
