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
  end
end
