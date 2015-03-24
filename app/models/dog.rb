class Dog < ActiveRecord::Base
  attr_reader :address, :location, :selection

  belongs_to :user
  has_one :search_preference
  has_many :observations
  has_many :views, class_name: "Observation", foreign_key: "observer_id"
  has_many :viewed_by,  class_name:  "Observation", foreign_key: "observed_id"
  has_attached_file :img, storage: :s3, bucket: ENV['BUCKET_NAME'],
                          default_url: "http://loremflickr.com/300/300/puppy"

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

  scope :to_view,     ->(id)          { where.not(id: Dog.find(id).already_viewed) }
  scope :by_breed,    ->(requested)   { where(breed: requested)}
  scope :by_age,      ->(requested)   { where(age: requested)}
  scope :by_size,     ->(requested)   { where(size: requested)}
  scope :by_gender,   ->(requested)   { where(gender: requested)}

  def self.filters(id)
    @selection = to_view(id)
    filter_breeds(id)
    filter_ages(id)
    filter_sizes(id)
    filter_gender(id)
    @selection
  end

  def self.breed_pref(id)
    find(id).search_preference.breeds
  end

  def self.age_pref(id)
    find(id).search_preference.ages
  end

  def self.gender_pref(id)
    find(id).search_preference.gender
  end

  def self.size_pref(id)
    find(id).search_preference.sizes
  end

  def self.distance_pref(id)
    find(id).search_preference.distance
  end

  def self.filter_breeds(id)
    if !breed_pref(id).include?("- ALL -") && !breed_pref(id).empty?
      @selection = @selection.by_breed(breed_pref(id))
    end
  end

  def self.filter_ages(id)
    if !age_pref(id).include?("- ALL -") && !age_pref(id).empty?
      @selection = @selection.by_age(age_pref(id))
    end
  end

  def self.filter_sizes(id)
    if !size_pref(id).include?("- ALL -") && !size_pref(id).empty?
      @selection = @selection.by_size(size_pref(id))
    end
  end

  def self.filter_gender(id)
    if !gender_pref(id).include?("- ALL -") && !size_pref(id).empty?
      @selection = @selection.by_gender(gender_pref(id))
    end
  end

  def self.filter_distance(id)
    if !distance_pref(id).empty?
      @selection = @selection.by_distance(distance_pref(id))
    end
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
