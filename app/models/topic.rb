class Topic < ActiveRecord::Base
  attr_accessible :section, :name, :section_id, :user_id

  belongs_to :section
  belongs_to :user

  has_many :replies, dependent: :destroy

  belongs_to :last_reply, class_name: 'Reply', foreign_key: 'last_reply_id'

  validates :user, presence: true
  validates :section, presence: true
  validates :name, presence: true

  include ActionView::Helpers

  # Create a first Topic in a Section with a content for a Reply.
  #
  # Returns a Reply if the parameters are valid, otherwise returns false
  def self.create_with_reply(params)
    self.transaction do
      topic = self.create!(name:       params[:name],
                           user_id:    params[:user_id],
                           section_id: params[:section_id])
      reply = topic.replies.create!(content: params[:content],
                                    user_id: params[:user_id])
      return topic
    end
  rescue ActiveRecord::RecordInvalid => e
    return false
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def to_simple_json
    {
      name: self.name,
      last_reply_at: time_ago_in_words(self.last_reply_at)
    }
  end

end
