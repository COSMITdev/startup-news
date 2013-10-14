require 'spec_helper'

describe User do
  describe "Validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_uniqueness_of(:email) }

    context "#username" do
      it { should_not allow_value('á').for(:username) }
      it { should_not allow_value('$').for(:username) }
      it { should_not allow_value('-').for(:username) }
      it { should_not allow_value('.').for(:username) }
      it { should_not allow_value("\n").for(:username) }
      it { should_not allow_value(nil).for(:username) }
      it { should_not allow_value('_').for(:username) }
      it { should_not allow_value('a space').for(:username) }
      it { should_not allow_value("blank\nline").for(:username) }

      it { should allow_value('a').for(:username) }
      it { should allow_value('z').for(:username) }
      it { should allow_value('0').for(:username) }
      it { should allow_value('9').for(:username) }
      it { should allow_value('a_').for(:username) }
      it { should allow_value('0_').for(:username) }
      it { should allow_value('A').for(:username) }
      it { should allow_value('Z').for(:username) }
      it { should allow_value('A_').for(:username) }
      it { should allow_value('Z_').for(:username) }
      it { should allow_value('A_0').for(:username) }
      it { should allow_value('A0_').for(:username) }
      it { should allow_value('A0_A').for(:username) }
      it { should allow_value('0_9').for(:username) }
    end
  end

  describe "Relations" do
    it { should have_many(:news).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:votes).dependent(:destroy) }
  end

  describe ".find_first_by_auth_conditions" do
    before { @user = User.make!(email: "bla@foo.com") }

    context "username as param" do
      context "With correct username" do
        it "Returns correct User" do
          User.find_first_by_auth_conditions({ username: @user.username }).should eq(@user)
        end
      end

      context "With incorrect username" do
        context "nil username and email" do
          it { User.find_first_by_auth_conditions({ username: nil, email: nil }).should be_nil }
        end

        context "Other username" do
          it { User.find_first_by_auth_conditions({ username: "another_username" }).should be_nil }
        end

        context "Empty username" do
          it { User.find_first_by_auth_conditions({ username: "" }).should be_nil }
        end
      end
    end

    context "email as param" do
      context "With correct email" do
        it "Returns correct User" do
          User.find_first_by_auth_conditions({ email: @user.email }).should eq(@user)
        end
      end

      context "With incorrect email" do
        context "nil email" do
          it { User.find_first_by_auth_conditions({ email: nil }).should be_nil }
        end

        context "Other email" do
          it { User.find_first_by_auth_conditions({ email: "another@email.com" }).should be_nil }
        end

        context "Empty email" do
          it { User.find_first_by_auth_conditions({ email: "" }).should be_nil }
        end
      end
    end
  end
end
