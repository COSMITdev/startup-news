require "spec_helper"

describe Contact do
  describe "send_email" do
    let(:mail) { Contact.send_email({}) }

    # ensure that the receiver is correct
    it "renders the receiver email" do
      mail.to.should include('contato@codeland.com.br')
    end

    # ensure that the sender is correct
    it "renders the sender email" do
      mail.from.should include("no-reply@codeland.com.br")
    end

    # ensure that the subject is correct
    it "renders the subject" do
      mail.subject.should == "Contato StartupNews"
    end
  end
end
