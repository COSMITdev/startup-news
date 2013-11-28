class CommentsController < InheritedResources::Base
  actions :create, :destroy, :edit, :update

  def create
    @comment         = Comment.new(permitted_params[:comment])
    @comment.user    = current_user
    @comment.news_id = params[:comment][:news_id]

    create! { news_path(@comment.news_id) }
  end

  # def edit
  #   @comment = Comment.find(params[:id])
  # end

  def update
    update!(notice: I18n.t('flash.comments.successful_update')) { news_path(resource.news) }
  end

  private

  def permitted_params
    params.permit(comment: [:text])
  end
end
