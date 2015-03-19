require 'rails_helper'

RSpec.describe SearchPreference, :type => :model do
  let(:user)  { User.create(first_name: "Krista") }

  let(:dog)     { Dog.create(name: "Rocko",
                   age: Selector.age.first,
                   size: Selector.size.first,
                   zipcode: 80218,
                   gender: "Male",
                   breed: "poodle",
                   user_id: user.id) }

  let(:search)  { { breeds: ["- All -"],
                    ages: [""],
                    sizes: ["Tiny: Less than 10 lbs"],
                    gender: ["Male", "Femail"],
                    distance: ["8"],
                    dog_id: dog.id } }

  it "it has an array of ages" do
    new_search = SearchPreference.create(search)

    expect(Array).to eq(new_search.ages.class)
  end

  it "it has an array of sizes" do
    new_search = SearchPreference.create(search)

    expect(Array).to eq(new_search.sizes.class)
  end

  it "it has an array of genderss" do
    new_search = SearchPreference.create(search)

    expect(Array).to eq(new_search.gender.class)
  end

  it "it has a dog" do
    new_search = SearchPreference.create(search)

    expect(dog).to eq(new_search.dog)
  end

end
