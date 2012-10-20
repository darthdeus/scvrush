module Player
  module ClassMethods
  end

  module InstanceMethods

    def registered_for?(tournament)
      return false if tournament.nil?
      !self.signups.registered.where(tournament_id: tournament.id).empty?
    end

    def checked_in?(tournament)
      return false if tournament.nil? || !user.respond_to?(:signups)
      !self.signups.checked.where(tournament_id: tournament.id).empty?
    end

    def sign_up(tournament)
      if !self.has_signup?(tournament)
        signup = self.signups.build(tournament: tournament)
        signup.status = Signup::REGISTERED
        signup.save!
        signup
      else
        self.signups.where(tournament_id: tournament.id).first
      end
    end

    def has_signup?(tournament)
      !self.signups.where(tournament_id: tournament.id).empty?
    end

    def check_in(tournament)
      signup = self.signups.where(tournament_id: tournament.id).first
      if signup
        signup.checkin!
      else
        raise NotRegistered.new("Trying to check in a user who isn't registered!")
      end
    end


  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
