require 'spec_helper'

describe AuthenticationsController do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  it "sets a session variable to the OmniAuth auth hash" do
    request.env["omniauth.auth"][:provider].should == 'facebook'
    request.env["omniauth.auth"][:uid].should == '1234'
    request.env["omniauth.auth"][:info][:name].should == 'John Doe'
    request.env["omniauth.auth"][:info][:email].should == 'johndoe@email.com'
  end
end
