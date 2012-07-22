class Relationship < ActiveRecord::Base

	scope :restricted, :conditions => ['relationships.restricted = ?', true]
  scope :unrestricted, :conditions => ['relationships.restricted = ?', false]
	
  scope :to_type, lambda {|rtype| rtype = [rtype].flatten.compact; rtype.size > 0 && {:conditions => ['relationships.requestee_type IN (?)', [rtype].flatten]} || {}}
  scope :from_type, lambda {|rtype| rtype = [rtype].flatten.compact; rtype.size > 0 && {:conditions => ['relationships.requestor_type IN (?)', [rtype].flatten]} || {}}
	
	default_scope :order => 'created_at DESC'
	
	with_options :polymorphic => true do |klazz|
		klazz.belongs_to :requestor
		klazz.belongs_to :requestee
	end
	
	validates_presence_of :requestor, :requestee
	
	alias_attribute :blocked, :restricted
	def accepted?
		!self.restricted
	end
	
	class << self
		alias_attribute :blocked, :restricted
		alias_attribute :unblocked, :unrestricted
	
		alias_attribute :unaccepted, :restricted
		alias_attribute :accepted, :unrestricted
	end
end
