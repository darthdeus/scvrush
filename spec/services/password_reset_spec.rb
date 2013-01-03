require "spec_helper"

describe PasswordReset do

  context "#reset_password" do
    let(:user) { create(:user) }
    subject { PasswordReset.new(user) }

    it "generates password_reset_token" do
      subject.reset_password
      user.password_reset_token.should be_present
    end

    it "sets a timestamp of when the password was reset" do
      subject.reset_password
      # TODO - use timecop to check for the exact time here
      user.password_reset_sent_at.should be_present
    end

  end
end
