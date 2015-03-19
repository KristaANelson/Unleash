class SearchPreference < ActiveRecord::Base
  belongs_to :dog
  serialize :breeds, Array
  serialize :ages, Array
  serialize :sizes, Array
  serialize :gender, Array
end
