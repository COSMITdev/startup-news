require 'spec_helper'

describe CommentsController do
  context "When logged in" do
    before do
      @news    ||= News.make!
      @comment ||= Comment.make!(user: @news.user, news: @news)
      @user    ||= @comment.user
      sign_in @user
    end

    let(:valid_create) {{
      'news_id' => @news.id,
      'user_id' => @user.id,
      'text' => 'lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet'
    }}

    it "POST create" do
      expect {
        post :create, comment: valid_create
      }.to change(Comment, :count).by(1)
    end

    it "DELETE destroy" do
      expect {
        delete :destroy, {id: @comment}
      }.to change(Comment, :count).by(-1)
    end
  end

  describe "#permitted_params" do
    context "Passing user_id" do
      before do
        @expected = {
          "comment" => {
            "text" => "text"
          }
        }
        parameters = ActionController::Parameters.new({
          comment: {
            user_id: "42",
            text: "text"
          }
        })
        controller.stub(:params).and_return(parameters)
      end

      its(:permitted_params) { should eq(@expected) }
    end

    context "Passing all valid attributes" do
      before do
        @expected = {
          "comment" => {
            "text" => "text"
          }
        }
        parameters = ActionController::Parameters.new({
          comment: {
            text: "text"
          }
        })
        controller.stub(:params).and_return(parameters)
      end

      its(:permitted_params) { should eq(@expected) }
    end

    context "Passing only text" do
      before do
        @expected = {
          "comment" => {
            "text" => "text"
          }
        }
        parameters = ActionController::Parameters.new({
          comment: {
            text: "text"
          }
        })
        controller.stub(:params).and_return(parameters)
      end

      its(:permitted_params) { should eq(@expected) }
    end

    context "Passing only invalid params" do
      before do
        @expected = {
          "comment" => {  }
        }
        parameters = ActionController::Parameters.new({
          comment: {
            something: true
          }
        })
        controller.stub(:params).and_return(parameters)
      end

      its(:permitted_params) { should eq(@expected) }
    end
  end
end
