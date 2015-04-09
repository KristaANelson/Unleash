class User < ActiveRecord::Base
  has_many :dogs

  def self.find_or_create_from_auth(auth)
    path = URI.parse(auth.info.image).path
    user = User.find_or_create_by(provider: auth.provider, uid: auth.uid)
    user.first_name   = auth.info.first_name
    user.last_name    = auth.info.last_name
    user.email        = auth.info.email
    user.oauth_token  = auth.credentials.token
    user.image_url    = "http://graph.facebook.com/#{path}/picture?type=square"
    user
  end

  def first_dog
    dogs.count == 1
  end
end
