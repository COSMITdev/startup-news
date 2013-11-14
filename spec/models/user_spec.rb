require 'spec_helper'
require 'ostruct'

describe User do
  let(:facebook_valid_auth) do
    OpenStruct.new(
      provider: 'facebook',
      uid: '409643015803769',
      info: OpenStruct.new(
        nickname: 'CODELAND',
        email: 'contato@codeland.com.br',
        name: 'Contato CODELAND',
        first_name: 'Contato',
        last_name: 'CODELAND',
        image: 'http://graph.facebook.com/CODELAND/picture?type=square',
        urls: OpenStruct.new(
          Facebook: 'http://www.facebook.com/CODELAND'
        ),
        location: 'Porto Alegre, Rio Grande do Sul',
        verified: true
      ),
      credentials: OpenStruct.new(
        token: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
        expires_at: 1321747205,
        expires: true
      ),
      extra: OpenStruct.new(
        raw_info: OpenStruct.new(
          id: '409643015803769',
          name: 'Contato CODELAND',
          first_name: 'Contato',
          last_name: 'CODELAND',
          link: 'http://www.facebook.com/CODELAND',
          username: 'CODELAND',
          location: OpenStruct.new(
            id: '123456789',
            name: 'Porto Alegre, Rio Grande do Sul'
          ),
          gender: 'male',
          email: 'contato@codeland.com.br',
          timezone: -3,
          locale: 'pt_BR',
          verified: true,
          updated_time: '2013-11-11T06:21:03+0000'
        )
      )
    )
  end

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
    it { should have_one(:authentication).dependent(:destroy) }
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

  describe ".create_with_facebook" do
    context "successful" do
      subject { User.create_with_facebook(facebook_valid_auth) }

      it "creates one User" do
        expect{
          subject
        }.to change(User, :count).by(1)
      end

      it "creates one Authentication" do
        expect{
          subject
        }.to change(Authentication, :count).by(1)
      end

      it { expect(subject).to be_a(User) }

      it { expect(subject.username).to eq(facebook_valid_auth.info.nickname) }

      it { expect(subject.email).to eq(facebook_valid_auth.info.email) }

      it { expect(subject.authentication.uid).to eq(facebook_valid_auth.uid) }

      it "returns a persisted User" do
        expect(subject).to be_persisted
      end
    end

    context "failing - already exists" do
      before { User.create_with_facebook(facebook_valid_auth) }

      subject { User.create_with_facebook(facebook_valid_auth) }

      it "not changes User.count" do
        expect{
          subject
        }.to_not change(User, :count)
      end

      it "not changes Authentication.count" do
        expect{
          subject
        }.to_not change(Authentication, :count)
      end

      it "returns a User" do
        expect(subject).to be_a(User)
      end

      it "returns a not persisted User" do
        expect(subject).to_not be_persisted
      end
    end
  end
end
