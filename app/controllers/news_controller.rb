class NewsController < InheritedResources::Base
  before_filter :authenticate_user!, except: [:index, :show, :newests]

  def newests
    
  end

  def create
    @news = News.new(permitted_params[:news])
    @news.user = current_user
    create!
  end

  def show
    @comment = Comment.new
    @resource = News.friendly.find(params[:id])
  end

  def my_news
    @my_news = current_user.news.page(params[:page]).per(20)
  end

  private

  def permitted_params
    params.permit(news: [:title, :link, :text])
  end
end
