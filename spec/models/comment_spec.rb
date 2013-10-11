require 'spec_helper'

describe Comment do
  context "Validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :text }
  end

  context "context" do
    it { should belong_to :user }
    it { should belong_to :news }
  end
end
