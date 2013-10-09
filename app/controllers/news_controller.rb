class NewsController < InheritedResources::Base
  before_filter :authenticate_user!, except:[:index]

  def create
    @news = News.new(permitted_params[:news])
    @news.user = current_user
    create!
  end

  private

  def permitted_params
    params.permit(news: [:title, :link, :text])
  end
end
