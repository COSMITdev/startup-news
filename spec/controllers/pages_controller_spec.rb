require 'spec_helper'

describe PagesController do
  context "When Logged In" do
    it "GET about" do
      get :about
      expect(response).to render_template('about')
    end

    it "GET contact" do
      get :contact
      expect(response).to render_template('contact')
    end
  end

  context "When Logged Out" do
    it "GET about" do
      get :about
      expect(response).to render_template('about')
    end

    it "GET contact" do
      get :contact
      expect(response).to render_template('contact')
    end
  end
end
