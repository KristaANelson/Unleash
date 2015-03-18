class Dog < ActiveRecord::Base
  attr_reader :address, :location
  belongs_to :user
  has_many :observations

  has_attached_file :img,
    storage: :s3,
    bucket: ENV['BUCKET_NAME']

  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/
  validates :name, presence: true, length: { in: 5..100 },
  format: { with: /\A[a-z ,.\'-]+\z/i, }
  validates :size, inclusion: { in:         Selector.size,
                                message:    "Please select a size option" }
  validates :age, inclusion: { in:          Selector.age,
                                message:    "Please select a weight option" }
  validates :gender, inclusion: { in:       Selector.gender,
                                  message:  "Please select a weight option" }

  def location
    Geokit::Geocoders::GoogleGeocoder.geocode(zipcode, :bias => 'us')
  end

  def distance(other_dog)
    location.distance_to(other_dog.location).round(2)
  end
end
