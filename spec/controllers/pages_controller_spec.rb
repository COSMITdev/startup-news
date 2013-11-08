require 'spec_helper'

describe PagesController do
  describe "#about" do
    it "renders about template" do
      get(:about)
      expect(response).to render_template('about')
    end
  end

  describe "#contact" do
    it "renders about template" do
      get(:contact)
      expect(response).to render_template('contact')
    end
  end

  describe "#dispatch_email" do
    context "making post before each" do
      before { post(:dispatch_email, { user_info: {  } }) }

      it "redirects to root" do
        expect(response).to redirect_to(root_path)
      end

      it "includes flash message" do
        expect(flash).to_not be_empty
      end

      it "includes notice flash message" do
        expect(flash[:notice]).to_not be_empty
      end

      it "notice flash message should be #{I18n.t('pages.dispatch_email.success_message')}" do
        expect(flash[:notice]).to eq(I18n.t('pages.dispatch_email.success_message'))
      end
    end

    context "making post after each" do
      after { post(:dispatch_email, { user_info: {  } }) }

      it "Contact#send_email called once" do
        Contact.any_instance.should_receive(:send_email).once
      end
    end
  end
end
