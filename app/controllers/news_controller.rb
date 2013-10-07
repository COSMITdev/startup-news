class NewsController < InheritedResources::Base
  before_filter :authenticate_user!, except:[:index]

  private

  def permitted_params
    params.permit(news:[:user_id, :title, :link, :text])
  end
end
