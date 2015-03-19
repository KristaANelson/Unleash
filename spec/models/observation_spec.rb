require 'rails_helper'

RSpec.describe Observation, :type => :model do
  let(:user)  { User.create(first_name: "Krista") }

  let(:dog)     { { name: "Rocko",
                    age: Selector.age.first,
                    size: Selector.size.first,
                    zipcode: 80218,
                    gender: "Male",
                    breed: "poodle",
                    user_id: user.id} }

    it "has an observer" do
      rocko = Dog.create(dog)
      bella = Dog.create(dog)
      ob = Observation.create(observer_id: rocko.id, observed_id: bella.id, distance: "8")

      assert ob.observer
    end

    it "has an observed" do
      rocko = Dog.create(dog)
      bella = Dog.create(dog)
      ob = Observation.create(observer_id: rocko.id, observed_id: bella.id, distance: "8")

      assert ob.observed
    end

    it "is has a distance" do
      rocko = Dog.create(dog)
      bella = Dog.create(dog)
      ob = Observation.create(observer_id: rocko.id, observed_id: bella.id, distance: "8")

      assert_equal "8", ob.distance
    end
  end
