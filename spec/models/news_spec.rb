require 'spec_helper'

describe News do
  describe "Validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :title }
    it { should validate_presence_of :link }
  end

  describe "#link" do
    it { should allow_value('http://lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:link) }
    it { should allow_value('https://lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:link) }
    it { should allow_value('http://www.lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:link) }
    it { should allow_value('https://www.lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:link) }

    it { should_not allow_value('lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:link) }
    it { should_not allow_value('lists. gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:link) }
    it { should_not allow_value('http://lists. gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:link) }
    it { should_not allow_value("\n").for(:link) }
    it { should_not allow_value('a space').for(:link) }
    it { should_not allow_value("blank\nline").for(:link) }
  end

  describe "Relations" do
    it { should belong_to :user }
    it { should have_many(:comments).dependent(:destroy)}
    it { should have_many(:votes).dependent(:destroy) }
  end

  describe "#rate_up" do
    it "changes :up by 1" do
      expect{
        subject.rate_up
      }.to change(subject, :up).by(1)
    end
  end

  describe "#rate_up" do
    it "changes :down by 1" do
      expect{
        subject.rate_down
      }.to change(subject, :down).by(1)
    end
  end

  describe "#change_existing_rate_to" do
    context "passing :up as parameter" do
      it "changes :down by -1" do
        expect{
          subject.change_existing_rate_to(:up)
        }.to change(subject, :down).by(-1)
      end

      it "changes :up by 1" do
        expect{
          subject.change_existing_rate_to(:up)
        }.to change(subject, :up).by(1)
      end
    end

    context "passing :down as parameter" do
      it "changes :down by 1" do
        expect{
          subject.change_existing_rate_to(:down)
        }.to change(subject, :down).by(1)
      end

      it "changes :up by -1" do
        expect{
          subject.change_existing_rate_to(:down)
        }.to change(subject, :up).by(-1)
      end
    end

    context "passing nil as parameter" do
      it "not changes :down" do
        expect{
          subject.change_existing_rate_to(nil)
        }.to_not change(subject, :down)
      end

      it "not changes :up" do
        expect{
          subject.change_existing_rate_to(nil)
        }.to_not change(subject, :up)
      end
    end

    context "not passing parameter" do
      it "changes :down by -1" do
        expect{
          subject.change_existing_rate_to
        }.to change(subject, :down).by(-1)
      end

      it "changes :up by 1" do
        expect{
          subject.change_existing_rate_to
        }.to change(subject, :up).by(1)
      end
    end

    context "passing :other_key as parameter" do
      it "not changes :down" do
        expect{
          subject.change_existing_rate_to(:other_key)
        }.to_not change(subject, :down)
      end

      it "not changes :up" do
        expect{
          subject.change_existing_rate_to(:other_key)
        }.to_not change(subject, :up)
      end
    end
  end

  describe "#update_rank" do
    it "updates :rank" do
      expect{
        subject.update_rank
      }.to change(subject, :rank)
    end

    context "ranking value" do
      context "considering created_at" do
        context "an older with a lot of ups its more relevant then a newer with more downs" do
          context "news of 10 days with 1,000,000,000 ups and 0 downs its more relevant than 2 days, 0 ups and 10,000,000 downs" do
            it "compare correct rank" do
              news_1 = News.new(up: 0, down: 10_000_000, created_at: 2.days.ago)
              news_2 = News.new(up: 1_000_000_000, down: 0, created_at: 10.days.ago)
              news_1.update_rank
              news_2.update_rank
              expect(news_2.rank).to be > news_1.rank
            end
          end

          context "news of 10 minutes with 1,000 ups and 10 downs its more relevant than 5 minutes, 800 ups and 100 downs" do
            it "compare correct rank" do
              news_1 = News.new(up: 800, down: 200, created_at: 5.minutes.ago)
              news_2 = News.new(up: 1_000, down: 10, created_at: 10.minutes.ago)
              news_1.update_rank
              news_2.update_rank
              expect(news_2.rank).to be > news_1.rank
            end
          end
        end

        context "more ups" do
          context "0 down, 10 up" do
            it "compare correct rank" do
              news_1 = News.new(up: 10, down: 0, created_at: 1.day.ago)
              news_2 = News.new(up: 10, down: 0, created_at: 10.days.ago)
              news_1.update_rank
              news_2.update_rank
              expect(news_1.rank).to be > news_2.rank
            end
          end

          context "9 down, 10 up" do
            it "compare correct rank" do
              news_1 = News.new(up: 10, down: 9, created_at: 1.day.ago)
              news_2 = News.new(up: 10, down: 9, created_at: 10.days.ago)
              news_1.update_rank
              news_2.update_rank
              expect(news_1.rank).to be > news_2.rank
            end
          end
        end

        context "more downs" do
          context "10 down, 0 up" do
            it "compare correct rank" do
              news_1 = News.new(up: 0, down: 10, created_at: 1.day.ago)
              news_2 = News.new(up: 0, down: 10, created_at: 10.days.ago)
              news_1.update_rank
              news_2.update_rank
              expect(news_1.rank).to be > news_2.rank
            end
          end

          context "10 down, 9 up" do
            it "compare correct rank" do
              news_1 = News.new(up: 9, down: 10, created_at: 1.day.ago)
              news_2 = News.new(up: 9, down: 10, created_at: 10.days.ago)
              news_1.update_rank
              news_2.update_rank
              expect(news_1.rank).to be > news_2.rank
            end
          end
        end

        context "up equals down" do
          context "0 down, 0 up" do
            it "compare correct rank" do
              news_1 = News.new(up: 0, down: 0, created_at: 1.day.ago)
              news_2 = News.new(up: 0, down: 0, created_at: 10.days.ago)
              news_1.update_rank
              news_2.update_rank
              expect(news_1.rank).to be > news_2.rank
            end
          end

          context "10 down, 10 up" do
            it "compare correct rank" do
              news_1 = News.new(up: 10, down: 10, created_at: 1.day.ago)
              news_2 = News.new(up: 10, down: 10, created_at: 10.days.ago)
              news_1.update_rank
              news_2.update_rank
              expect(news_1.rank).to be > news_2.rank
            end
          end
        end
      end

      context "ignoring created_at" do
        before { News.any_instance.stub(:created_at).and_return(DateTime.new(2013, 10, 9, 21, 21)) }

        context "more ups" do
          context "0 down, 10 up" do
            it "returns correct rank" do
              news = News.new(up: 10, down: 0)
              news.update_rank
              expect(news.rank).to eq(5497.125711111111)
            end
          end

          context "9 down, 10 up" do
            it "returns correct rank" do
              news = News.new(up: 10, down: 9)
              news.update_rank
              expect(news.rank).to eq(5496.125711111111)
            end
          end
        end

        context "more downs" do
          context "10 down, 0 up" do
            it "returns correct rank" do
              news = News.new(up: 0, down: 10)
              news.update_rank
              expect(news.rank).to eq(5495.125711111111)
            end
          end

          context "10 down, 9 up" do
            it "returns correct rank" do
              news = News.new(up: 9, down: 10)
              news.update_rank
              expect(news.rank).to eq(5496.125711111111)
            end
          end
        end

        context "up equals to down" do
          context "0 down, 0 up" do
            it "returns correct rank" do
              news = News.new(up: 0, down: 0)
              news.update_rank
              expect(news.rank).to eq(5496.125711111111)
            end
          end

          context "10 down, 10 up" do
            it "returns correct rank" do
              news = News.new(up: 10, down: 10)
              news.update_rank
              expect(news.rank).to eq(5496.125711111111)
            end
          end
        end
      end
    end
  end

  describe ".by_ranking" do
    subject { News.by_ranking }

    it { should be_a(ActiveRecord::Relation) }

    it "Order by :rank decrescent" do
      subject.to_sql.should include("ORDER BY rank DESC")
    end
  end
end
