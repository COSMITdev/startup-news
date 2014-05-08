class NewsController < InheritedResources::Base
  before_filter :authenticate_user!, except: [:index, :show, :newests]

  def index
    @shortname = ENV['DISQUS_SHORTNAME']    
  end

  def newests
    @news = News.newests

    respond_to do |format|
      format.html
      format.atom
    end
  end

  def create
    @news = News.new(permitted_params[:news])
    @news.user = current_user 
    create!
  end

  def show
    @shortname = ENV['DISQUS_SHORTNAME']
    show!
  end

  def my_news
    @my_news = current_user.news.page(params[:page]).per(20)
  end

  private

  def permitted_params
    params.permit(news: [:title, :link, :text])
  end

  def resource
    @news ||= News.friendly.find(params[:id])
  end
end
