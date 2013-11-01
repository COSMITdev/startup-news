require 'spec_helper'

describe NewsHelper do
  describe "#host_for_link" do
    context "normal url" do
      subject { helper.host_for_link("http://www.codeland.com.br") }

      it { should eq("codeland.com.br") }
    end

    context "url with path" do
      subject { helper.host_for_link("http://www.codeland.com.br/my/path") }

      it { should eq("codeland.com.br") }
    end

    context "url with fragment" do
      subject { helper.host_for_link("http://www.codeland.com.br/#root") }

      it { should eq("codeland.com.br") }
    end

    context "url with query" do
      subject { helper.host_for_link("http://www.codeland.com.br/?query=true") }

      it { should eq("codeland.com.br") }
    end

    context "url with file extension" do
      subject { helper.host_for_link("http://www.codeland.com.br/index.html") }

      it { should eq("codeland.com.br") }
    end

    context "naked domain" do
      subject { helper.host_for_link("http://codeland.com.br") }

      it { should eq("codeland.com.br") }
    end

    context "url with subdomain" do
      context "normal url" do
        subject { helper.host_for_link("http://blog.codeland.com.br") }

        it { should eq("blog.codeland.com.br") }
      end

      context "with path" do
        subject { helper.host_for_link("http://blog.codeland.com.br/my/path") }

        it { should eq("blog.codeland.com.br") }
      end

      context "direct url" do
        subject { helper.host_for_link("http://blog.codeland.com.br") }

        it { should eq("blog.codeland.com.br") }
      end

      context "with query" do
        subject { helper.host_for_link("http://blog.codeland.com.br/?query=true") }

        it { should eq("blog.codeland.com.br") }
      end

      context "with fragment" do
        subject { helper.host_for_link("http://blog.codeland.com.br/#root") }

        it { should eq("blog.codeland.com.br") }
      end
    end
  end
end
