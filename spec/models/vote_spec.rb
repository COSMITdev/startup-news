require 'spec_helper'

describe Vote do
  describe "Validations" do
    it { should validate_presence_of(:ip) }
    it { should validate_presence_of(:news) }
    it { should allow_value(false).for(:is_up) }
    it { should allow_value(true).for(:is_up) }
    it { should_not allow_value(nil).for(:is_up) }
  end

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:news) }
  end

  describe "#up?" do
    context "is_up == true" do
      before { Vote.any_instance.stub(:is_up?).and_return(true) }

      its(:up?) { should be_true }
    end

    context "is_up == false" do
      before { Vote.any_instance.stub(:is_up?).and_return(false) }

      its(:up?) { should be_false }
    end
  end

  describe "#down?" do
    context "is_up == true" do
      before { Vote.any_instance.stub(:is_up?).and_return(true) }

      its(:down?) { should be_false }
    end

    context "is_up == false" do
      before { Vote.any_instance.stub(:is_up?).and_return(false) }

      its(:down?) { should be_true }
    end
  end

  describe "#change_vote" do
    context "up to down" do
      subject { Vote.new(is_up: true, news: stub_model(News)) }

      it "changes is_up to false" do
        expect{
          subject.change_vote
        }.to change(subject, :is_up).from(true).to(false)
      end
    end

    context "down to up" do
      subject { Vote.new(is_up: false, news: stub_model(News)) }

      it "changes is_up to true" do
        expect{
          subject.change_vote
        }.to change(subject, :is_up).from(false).to(true)
      end
    end
  end

  describe ".find_user_for_news" do
    context "user doesnt vote yet" do
      it "returns nil" do
        expect(Vote.find_user_for_news(User.make!, News.make!)).to be_nil
      end
    end

    context "user voted for other news" do
      it "returns nil" do
        user = User.make!
        Vote.make!(user: user)
        expect(Vote.find_user_for_news(user, News.make!)).to be_nil
      end
    end

    context "user already voted for this news" do
      before do
        @user = User.make!
        @news = News.make!
        @vote = Vote.make!(user: @user, news: @news)
      end

      it "returns a Vote" do
        expect(Vote.find_user_for_news(@user, @news)).to be_a(Vote)
      end

      it "returns correct vote" do
        expect(Vote.find_user_for_news(@user, @news)).to eq(@vote)
      end
    end
  end

  describe ".find_ip_for_news" do
    context "user doesnt vote yet" do
      it "returns nil" do
        expect(Vote.find_ip_for_news("123.255.255.012", News.make!)).to be_nil
      end
    end

    context "user voted for other news" do
      it "returns nil" do
        ip = "123.123.123.123"
        Vote.make!(ip: ip)
        expect(Vote.find_ip_for_news(ip, News.make!)).to be_nil
      end
    end

    context "user already voted for this news" do
      before do
        @the_ip = "123.123.123.123"
        @news = News.make!
        @vote = Vote.make!(ip: @the_ip, news: @news)
      end

      it "returns a Vote" do
        expect(Vote.find_ip_for_news(@the_ip, @news)).to be_a(Vote)
      end

      it "returns correct vote" do
        expect(Vote.find_ip_for_news(@the_ip, @news)).to eq(@vote)
      end
    end
  end

  describe "#update_news_rank" do
    context "rate_down" do
      before { Vote.any_instance.stub(:rate_method).and_return(:rate_down) }

      it "calls news.rate_down after create" do
        News.any_instance.should_receive(:rate_down).once
        Vote.make!
      end
    end

    context "rate_up" do
      before { Vote.any_instance.stub(:rate_method).and_return(:rate_up) }

      it "calls news.rate_up after create" do
        News.any_instance.should_receive(:rate_up).once
        Vote.make!
      end
    end
  end

  describe "#rate_method" do
    context "rate_down" do
      before { Vote.any_instance.stub(:is_up?).and_return(false) }

      its(:rate_method) { should be(:rate_down) }
    end

    context "rate_up" do
      before { Vote.any_instance.stub(:is_up?).and_return(true) }

      its(:rate_method) { should be(:rate_up) }
    end
  end
end
