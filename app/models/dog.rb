class Dog < ActiveRecord::Base
  attr_reader :address, :location, :selection

  belongs_to :user
  has_one :search_preference
  has_many :observations
  has_many :views, class_name: "Observation", foreign_key: "observer_id"
  has_many :viewed_by,  class_name:  "Observation", foreign_key: "observed_id"
  has_attached_file :img, storage: :s3, bucket: ENV['BUCKET_NAME'],
                    default_url: "puppy1.jpeg", styles: { :original =>"200x200#",  }

  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/
  validates :age,     inclusion: {  in:       Selector.age,
                                    message:  "Please select an age option" }
  validates :size,    inclusion: {  in:       Selector.size,
                                    message:  "Please select a size option" }
  validates :gender,  inclusion: {  in:       Selector.gender,
                                    message:  "Please select a gender option" }
  validates :breed,   inclusion: {  in:       Selector.breed,
                                    message:  "Please select a breed option" }
  validates :name,    length:   { in: 2..100 },
                      format:   { with: /\A[a-z ,.\'-]+\z/i, }

  validates :zipcode, length:   { is: 5 , message: "Invalid Zipcode"},
                      format:   { with: /[0-9]/, message: "Must be a number" }

  scope :not_viewed_by, ->(dog) { where.not(id: dog.already_viewed) }


  def self.filter_breeds(requested)
    return all if requested.include?("- ALL -") || requested.empty?
    where(breed: requested)
  end

  def self.filter_ages(requested)
    return all if requested.include?("- ALL -") || requested.empty?
    where(age: requested)
  end

  def self.filter_sizes(requested)
    return all if requested.include?("- ALL -") || requested.empty?
    where(size: requested)
  end

  def self.filter_gender(requested)
    return all if requested.include?("- ALL -") || requested.empty?
    where(gender: requested)
  end

  def self.apply_filters(dog)
    requested = dog.search_preference
    not_viewed_by(dog).filter_breeds(requested.breeds)
                      .filter_ages(requested.ages)
                      .filter_sizes(requested.sizes)
                      .filter_gender(requested.gender)
  end

  def location
    Geokit::Geocoders::GoogleGeocoder.geocode(zipcode, :bias => 'us')
  end

  def distance(other_dog)
    location.distance_to(other_dog.location).round(1)
  end

  def matches
    viewed_by.where(liked: true).map(&:observer_id).select do |like|
      views.where(liked: true).map(&:observed_id).include?(like)
    end
  end

  def already_viewed
    views.map(&:observed_id) << id
  end
end
