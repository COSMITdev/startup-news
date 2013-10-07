require 'spec_helper'

describe NewsController do
  context "When logged in" do
    before do
      @news ||= News.make!
      @user ||= @news.user
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
      patch :update, id: @news, news: valid_update
      @news.reload
      expect(@news.title).to eql 'Título de teste modificado'
    end

    it "GET index" do
      get :index
      response.should be_success
    end

    it "GET show" do
      get :show, id: @news
      response.should be_success
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
end
