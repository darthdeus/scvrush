module BattleNet
  module ClassMethods
    def races_collection
      %w{Zerg Terran Protoss Random}
    end

    def leagues_collection
      %w{Bronze Silver Gold Platinum Diamond Master Grandmaster}
    end

    def servers_collection
      %w{NA EU SEA KR}
    end

  end

  module InstanceMethods
    def has_bnet_username?
      self.bnet_username.present? && self.bnet_code.present?
    end

    def bnet_info
      "#{self.bnet_username}.#{self.bnet_code}"
    end

    def bnet_info?
      self.bnet_username? && self.bnet_code?
    end

  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
