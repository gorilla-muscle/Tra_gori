require "rails_helper"

RSpec.describe UserMailer do
  describe "reset_password_email" do
    let(:mail) { described_class.reset_password_email }

    it "renders the correct subject" do
      expect(mail.subject).to eq("Reset password email")
    end

    it "sends to the correct recipient" do
      expect(mail.to).to eq(["to@example.org"])
    end

    it "has the correct sender" do
      expect(mail.from).to eq(["from@example.com"])
    end
  end

  describe "renders the body" do
    let(:mail) { described_class.reset_password_email }

    it "includes 'Hi' in the body of the email" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
end
