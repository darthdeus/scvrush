class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :users_roles
  belongs_to :resource, polymorphic: true

  # TODO - are these really supposed to be accessible?
  attr_accessible :name, :resource_id, :resource_type

  scopify
end
