require 'spec_helper'

describe User do
  describe "Validations" do
    it { should validate_presence_of :username }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_uniqueness_of :username }
    it { should validate_uniqueness_of :email }

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
end
