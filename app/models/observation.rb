class Observation < ActiveRecord::Base
  belongs_to :dog

  scope :views, ->(id) { where(dog_id: id) }
  scope :likes, -> (id){ views(id).where(liked: true) }
  scope :liked_back, ->(id) { where(observed_id: id) }
end
