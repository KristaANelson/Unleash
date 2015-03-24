class User < ActiveRecord::Base
  has_many :dogs

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth.provider, uid: auth.uid)
    user.first_name   = auth.info.first_name
    user.last_name    = auth.info.last_name
    user.email        = auth.info.email
    user.oauth_token  = auth.credentials.token
    user.image_url    = auth.info.image
    user.save!
    user
  end

  def first_dog
    dogs.empty?
  end
end
