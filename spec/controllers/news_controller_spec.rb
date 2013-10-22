require 'spec_helper'

describe NewsController do
  context "When logged in" do
    before do
      @news ||= News.make!
      @user ||= @news.user
      @my_news = []
      @my_news << @news
      sign_in @user
    end
    let(:valid_create) {{
      'user_id' => @user.id,
      'title' => 'Título de teste',
      'link' => 'http://lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html',
      'text' => 'lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet'
    }}

    let(:valid_update) {{
      'title' => 'Título de teste modificado',
    }}

    it "POST create" do
       expect {
         post :create, news: valid_create
       }.to change(News, :count).by(1)
    end

    it "PATCH update" do
      expect{
        patch :update, id: @news.to_param, news: valid_update
      }.to change{ @news.reload.title }.to('Título de teste modificado')
    end

    it "GET index" do
      get :index
      response.should be_success
    end

    it "GET show" do
      get :show, id: @news
      response.should be_success
    end

    it "GET newests" do
      get :newests
      response.should be_success
    end

    it "GET my_news" do
      5.times do
        @my_news << News.make!(user: @user)
      end

      get :my_news

      assigns(:my_news).should =~ @my_news
    end

    it "GET edit" do
      get :edit, id: @news
      response.should be_success
    end

    it "DELETE destroy" do
      expect {
        delete :destroy, {id: @news}
      }.to change(News, :count).by(-1)
    end
  end

  describe "#permitted_params" do
    context "Passing user_id" do
      before do
        @expected = {
          "news" => {
            "link" => "link",
            "text" => "text",
            "title" => "title"
          }
        }
        parameters = ActionController::Parameters.new({
          news: {
            user_id: "42",
            link: "link",
            text: "text",
            title: "title"
          }
        })
        controller.stub(:params).and_return(parameters)
      end

      its(:permitted_params) { should eq(@expected) }
    end

    context "Passing all valid attributes" do
      before do
        @expected = {
          "news" => {
            "link" => "link",
            "text" => "text",
            "title" => "title"
          }
        }
        parameters = ActionController::Parameters.new({
          news: {
            link: "link",
            text: "text",
            title: "title"
          }
        })
        controller.stub(:params).and_return(parameters)
      end

      its(:permitted_params) { should eq(@expected) }
    end

    context "Passing only link" do
      before do
        @expected = {
          "news" => {
            "link" => "link"
          }
        }
        parameters = ActionController::Parameters.new({
          news: {
            link: "link"
          }
        })
        controller.stub(:params).and_return(parameters)
      end

      its(:permitted_params) { should eq(@expected) }
    end

    context "Passing only text" do
      before do
        @expected = {
          "news" => {
            "text" => "text"
          }
        }
        parameters = ActionController::Parameters.new({
          news: {
            text: "text"
          }
        })
        controller.stub(:params).and_return(parameters)
      end

      its(:permitted_params) { should eq(@expected) }
    end

    context "Passing title" do
      before do
        @expected = {
          "news" => {
            "title" => "title"
          }
        }
        parameters = ActionController::Parameters.new({
          news: {
            title: "title"
          }
        })
        controller.stub(:params).and_return(parameters)
      end

      its(:permitted_params) { should eq(@expected) }
    end

    context "Passing only invalid params" do
      before do
        @expected = {
          "news" => {  }
        }
        parameters = ActionController::Parameters.new({
          news: {
            admin: true,
            user_id: 42,
            up: 2000,
            down: 2000
          }
        })
        controller.stub(:params).and_return(parameters)
      end

      its(:permitted_params) { should eq(@expected) }
    end
  end
end
