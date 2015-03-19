class Observation < ActiveRecord::Base
  belongs_to :observer, class_name: "Dog"
  belongs_to :observed, class_name: "Dog"
end
