class Section < ActiveRecord::Base
  has_many :topics, dependent: :destroy

  validates :name, presence: true

  # Create a first Topic with a Reply for a given section.
  #
  # Returns the Reply if everything was successful, otherwise returns false
  def self.create_first_topic(params, user)
    unless params.has_key?(:section_id) && params.has_key?(:topic)
      return false
    end

    section = self.find(params[:section_id])

    topic_attributes = {
      name: params[:topic][:name],
      content: params[:topic][:content],
      section_id: params[:section_id],
      user_id: user.id
    }
    result = Topic.create_with_reply(topic_attributes)
    return result
  end

end
