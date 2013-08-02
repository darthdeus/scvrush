class TrialEmailValidator < ActiveModel::Validator

  def validate(record)
    if record.validate_trial_email && record.email =~ /trial\.scvrush\.com/
      record.errors[:email] << "You need to provide your email to activate the account."
    end
  end

end
