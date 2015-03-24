class Observation < ActiveRecord::Base
  belongs_to :observer, class_name: "Dog"
  belongs_to :observed, class_name: "Dog"

  scope :matches, ->(current_dog) { includes(:observed)
                                    .where(observer_id: current_dog.id,
                                    observed_id: current_dog.matches) }
end
