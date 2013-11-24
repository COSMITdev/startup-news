class CommentsController < InheritedResources::Base
  actions :create, :destroy, :edit

  def create
    @comment         = Comment.new(permitted_params[:comment])
    @comment.user    = current_user
    @comment.news_id = params[:comment][:news_id]

    create! { news_path(@comment.news_id) }
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(admin_comments_path, :notice => 'Comentário foi editado com sucesso') }
        format.xml  { head :no_content }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def permitted_params
    params.permit(comment: [:text])
  end
end
