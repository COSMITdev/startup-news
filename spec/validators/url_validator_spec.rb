require 'spec_helper'

describe UrlValidator do
  def validate_with(value, attribute = "site")
    @validator.validate_each(@mock, attribute, value)
  end

  before do
    @validator = UrlValidator.new({ attributes: [:site] })
    @mock = double('model')
    @mock.stub(:errors).and_return([])
    @mock.errors.stub(:[]).and_return({})
  end

  context "HTTP" do
    before { @mock.should_not_receive('errors') }

    it { validate_with("http://codeland.com.br/") }

    it { validate_with("http://www.codeland.com.br/") }

    it { validate_with("http://codeland.com.br/path") }

    it { validate_with("http://www.codeland.com.br/path") }

    it { validate_with("http://codeland.com.br/#!/path") }
  end

  context "HTTPS" do
    before { @mock.should_not_receive('errors') }

    it { validate_with("https://codeland.com.br/") }

    it { validate_with("https://www.codeland.com.br/") }

    it { validate_with("https://codeland.com.br/path") }

    it { validate_with("https://www.codeland.com.br/path") }

    it { validate_with("https://codeland.com.br/#!/path") }
  end

  context "Invalid URLs" do
    before { @mock.errors[].should_receive('<<').once }

    context "invalid path" do
      it { validate_with("http://codeland.com.br/{B5A2}") }
    end

    context "invalid protocol" do
      it { validate_with("httpp://codeland.com.br/") }
      it { validate_with("http:codeland.com.br/") }
      it { validate_with("https:codeland.com.br/") }
      it { validate_with("httpss://codeland.com.br/") }
    end

    context "invalid url" do
      it { validate_with("codeland.com.br") }
      it { validate_with("www.codeland.com.br") }
    end
  end
end
