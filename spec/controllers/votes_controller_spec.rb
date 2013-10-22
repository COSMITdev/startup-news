require 'spec_helper'

describe VotesController do
  describe "#create" do
    context "successfull new vote" do
      context "signed user" do
        before do
          controller.request.stub(:ip).and_return("127.0.0.1")
          sign_in @user = User.make!
        end

        context "up vote" do
          it "calls Vote.find_user_for_news and returns false" do
            Vote.should_receive(:find_user_for_news)
            post(:create, { id: News.make!, vote: "up" })
          end

          it "returns 201 status" do
            post(:create, { id: News.make!, vote: "up" })
            expect(response.status).to eq(201)
          end

          it "returns nothing" do
            post(:create, { id: News.make!, vote: "up" })
            expect(response.body).to eq(" ")
          end

          it "creates a new Vote" do
            expect{
              post(:create, { id: News.make!, vote: "up" })
            }.to change(Vote, :count).by(1)
          end

          it "assigns @vote with a Vote" do
            post(:create, { id: News.make!, vote: "up" })
            expect(assigns(:vote)).to be_a(Vote)
          end

          it "assigns current_user to vote.user" do
            post(:create, { id: News.make!, vote: "up" })
            expect(assigns(:vote).user).to eq(@user)
          end

          it "assigns current ip to vote.ip" do
            post(:create, { id: News.make!, vote: "up" })
            expect(assigns(:vote).ip).to eq("127.0.0.1")
          end

          it "assigns correct news to vote.news" do
            post(:create, { id: news = News.make!, vote: "up" })
            expect(assigns(:vote).news).to eq(news)
          end

          it "assigns false to vote.is_up" do
            post(:create, { id: News.make!, vote: "up" })
            expect(assigns(:vote).is_up).to be_true
          end
        end

        context "vote down" do
          it "calls Vote.find_user_for_news and returns false" do
            Vote.should_receive(:find_user_for_news)
            post(:create, { id: News.make!, vote: "down" })
          end

          it "returns 201 status" do
            post(:create, { id: News.make!, vote: "down" })
            expect(response.status).to eq(201)
          end

          it "returns nothing" do
            post(:create, { id: News.make!, vote: "down" })
            expect(response.body).to eq(" ")
          end

          it "creates a new Vote" do
            expect{
              post(:create, { id: News.make!, vote: "down" })
            }.to change(Vote, :count).by(1)
          end

          it "assigns @vote with a Vote" do
            post(:create, { id: News.make!, vote: "down" })
            expect(assigns(:vote)).to be_a(Vote)
          end

          it "assigns current_user to vote.user" do
            post(:create, { id: News.make!, vote: "down" })
            expect(assigns(:vote).user).to eq(@user)
          end

          it "assigns current ip to vote.ip" do
            post(:create, { id: News.make!, vote: "down" })
            expect(assigns(:vote).ip).to eq("127.0.0.1")
          end

          it "assigns correct news to vote.news" do
            post(:create, { id: news = News.make!, vote: "down" })
            expect(assigns(:vote).news).to eq(news)
          end

          it "assigns false to vote.is_up" do
            post(:create, { id: News.make!, vote: "down" })
            expect(assigns(:vote).is_up).to be_false
          end
        end
      end
    end

    context "successfull change of vote" do
      context "signed user" do
        before { sign_in @user = User.make! }

        context "change up to down" do
          before { @vote = Vote.make!(is_up: true, user: @user) }

          it "changes vote of news" do
            expect{
              post(:create, { id: @vote.news.to_param, vote: "down" })
            }.to change{@vote.reload.is_up}.from(true).to(false)
          end

          it "calls news.change_existing_rate_to(:down)" do
            News.any_instance.should_receive(:change_existing_rate_to).with(:down).once
            post(:create, { id: @vote.news.to_param, vote: "down" })
          end

          it "Vote.find_user_for_news returns true" do
            Vote.should_receive(:find_user_for_news).with(@user, @vote.news)
            post(:create, { id: @vote.news.to_param, vote: "down" })
          end

          context "with a post before each" do
            before { post(:create, { id: @vote.news.to_param, vote: "down" }) }

            it { response.status.should eq(200) }

            it { response.body.should eq(" ") }
          end
        end

        context "change down to up" do
          before { @vote = Vote.make!(is_up: false, user: @user) }

          it "changes vote of news" do
            expect{
              post(:create, { id: @vote.news.to_param, vote: "up" })
            }.to change{@vote.reload.is_up}.from(false).to(true)
          end

          it "calls news.change_existing_rate_to(:up)" do
            News.any_instance.should_receive(:change_existing_rate_to).with(:up).once
            post(:create, { id: @vote.news.to_param, vote: "up" })
          end

          it "Vote.find_user_for_news returns true" do
            Vote.should_receive(:find_user_for_news).with(@user, @vote.news)
            post(:create, { id: @vote.news.to_param, vote: "up" })
          end

          context "with a post before each" do
            before { post(:create, { id: @vote.news.to_param, vote: "up" }) }

            it { response.status.should eq(200) }

            it { response.body.should eq(" ") }
          end
        end
      end
    end

    context "failure" do
      context "signed user" do
        before { sign_in @user = User.make! }

        context "already voted" do
          before do
            @news = News.make!
          end

          context "up vote" do
            before do
              @vote = Vote.make!(news: @news, user: @user, is_up: true)
              post(:create, { id: @news.to_param, vote: "up" })
            end

            it "errors includes #{I18n.t("errors.vote.already_vote")}" do
              expect(JSON.parse(response.body)["errors"]).to include(I18n.t("errors.vote.already_vote"))
            end
          end

          context "down vote" do
            before do
              @vote = Vote.make!(news: @news, user: @user, is_up: false)
              post(:create, { id: @news.to_param, vote: "down" })
            end

            it "errors includes #{I18n.t("errors.vote.already_vote")}" do
              expect(JSON.parse(response.body)["errors"]).to include(I18n.t("errors.vote.already_vote"))
            end
          end
        end

        context "a failure on save" do
          before { Vote.any_instance.should_receive(:save).and_return(false) }

          context "up vote" do
            before { post(:create, { id: News.make!.to_param, vote: "up" }) }

            it "returns 403" do
              expect(response.status).to eq(403)
            end

            it "returns a JSON" do
              expect(JSON.parse(response.body)).to have_key("errors")
            end
          end

          context "down vote" do
            before { post(:create, { id: News.make!.to_param, vote: "down" }) }

            it "returns 403" do
              expect(response.status).to eq(403)
            end

            it "returns a JSON" do
              expect(JSON.parse(response.body)).to have_key("errors")
            end
          end
        end
      end

      context "guest user" do
        context "up vote" do
          before { post(:create, { id: News.make!.to_param, vote: "up" }) }

          it "returns 302" do
            expect(response.status).to eq(302)
          end

          it "body includes new_user_session_url" do
            expect(response.body).to include(new_user_session_url)
          end

          it "redirects to new_user_session_path" do
            expect(response).to redirect_to(new_user_session_path)
          end
        end

        context "down vote" do
          before { post(:create, { id: News.make!.to_param, vote: "down" }) }

          it "returns 302" do
            expect(response.status).to eq(302)
          end

          it "body includes new_user_session_url" do
            expect(response.body).to include(new_user_session_url)
          end

          it "redirects to new_user_session_path" do
            expect(response).to redirect_to(new_user_session_path)
          end
        end
      end
    end
  end

  describe "#can_update_existing_vote?" do
    context "params[:vote] == 'up'" do
      before { subject.stub(:params).and_return({ vote: "up" }) }

      context "vote.down? == true" do
        it "returns true" do
          method = subject.__send__(:can_update_existing_vote?, Vote.new(is_up: false))
          expect(method).to be_true
        end
      end

      context "vote.down? == false" do
        it "returns false" do
          method = subject.__send__(:can_update_existing_vote?, Vote.new(is_up: true))
          expect(method).to be_false
        end
      end
    end

    context "params[:vote] == 'down'" do
      before { subject.stub(:params).and_return({ vote: "down" }) }

      context "vote.up? == true" do
        it "returns true" do
          method = subject.__send__(:can_update_existing_vote?, Vote.new(is_up: true))
          expect(method).to be_true
        end
      end

      context "vote.up? == false" do
        it "returns false" do
          method = subject.__send__(:can_update_existing_vote?, Vote.new(is_up: false))
          expect(method).to be_false
        end
      end
    end

    context "params[:vote] == 'other'" do
      before { subject.stub(:params).and_return({ vote: "other" }) }

      context "vote.up? == true" do
        it "returns false" do
          method = subject.__send__(:can_update_existing_vote?, Vote.new(is_up: true))
          expect(method).to be_false
        end
      end

      context "vote.down? == false" do
        it "returns false" do
          method = subject.__send__(:can_update_existing_vote?, Vote.new(is_up: false))
          expect(method).to be_false
        end
      end
    end
  end

  describe "#vote_symbol" do
    context "params[:vote] == 'up'" do
      before { subject.stub(:params).and_return({ vote: "up" }) }

      it "returns :up" do
        expect(subject.__send__(:vote_symbol)).to eq(:up)
      end
    end

    context "params[:vote] == 'down'" do
      before { subject.stub(:params).and_return({ vote: "down" }) }

      it "returns :down" do
        expect(subject.__send__(:vote_symbol)).to eq(:down)
      end
    end

    context "params[:vote] == 'other'" do
      before { subject.stub(:params).and_return({ vote: "other" }) }

      it "returns nil" do
        expect(subject.__send__(:vote_symbol)).to be_nil
      end
    end
  end

  describe "#vote_value" do
    context "vote_symbol is :up" do
      before { subject.stub(:vote_symbol).and_return(:up) }

      it "returns true" do
        subject.__send__(:vote_value).should be_true
      end
    end

    context "vote_symbol is :down" do
      before { subject.stub(:vote_symbol).and_return(:down) }

      it "returns false" do
        subject.__send__(:vote_value).should be_false
      end
    end

    context "vote_symbol is nil" do
      before { subject.stub(:vote_symbol).and_return(nil) }

      it "returns nil" do
        subject.__send__(:vote_value).should be_nil
      end
    end
  end
end
