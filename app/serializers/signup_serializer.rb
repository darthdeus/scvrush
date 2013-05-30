class SignupSerializer < ActiveModel::Serializer
  attributes :id, :tournament_id, :user_id, :status

  has_one :user

  def status
    case object.status
    when Signup::REGISTERED then "registered"
    when Signup::CHECKED then "checked"
    when Signup::CANCELED then "canceled"
    end
  end
end
