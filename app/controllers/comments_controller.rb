class CommentsController < InheritedResources::Base
  actions :create, :destroy

  def create
    @comment         = Comment.new(permitted_params[:comment])
    @comment.user    = current_user
    @comment.news_id = params[:comment][:news_id]

    create! { news_path(@comment.news_id) }
  end

  private

  def permitted_params
    params.permit(comment: [:text])
  end
end
