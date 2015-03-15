class Dog < ActiveRecord::Base
  attr_reader :address
  belongs_to :user
  has_many :observations

  has_attached_file :img,
    storage: :s3,
    bucket: ENV['BUCKET_NAME']

  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/

  def address
    [street, city, state, zipcode].join(", ")
  end

  def location
    Geokit::Geocoders::GoogleGeocoder.geocode(address, :bias => 'us')
  end
end
