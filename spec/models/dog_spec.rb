require 'rails_helper'

RSpec.describe Dog, :type => :model do
  let(:user)  { User.create(first_name: "Krista") }

  let(:dog)     { { name: "Rocko",
                   age: Selector.age.first,
                   size: Selector.size.first,
                   zipcode: 80218,
                   gender: "Male",
                   breed: "poodle",
                   user_id: user.id} }

  it "is invalid without a name" do
    dog[:name] = nil
    rocko = Dog.new(dog)

    expect(rocko).not_to be_valid
  end

  it "is invalid without an age" do
    dog[:age] = nil
    rocko = Dog.new(dog)

    expect(rocko).not_to be_valid
  end

  it "is not valid without a size" do
    dog[:size] = nil
    rocko = Dog.new(dog)

    expect(rocko).not_to be_valid
  end

  it "is not valid without a breed a breed" do
    dog[:breed] = nil
    rocko = Dog.new(dog)

    expect(rocko).not_to be_valid
  end

  it "has a correctly formatted zipcode address" do
    dog[:zipcode] = "kjhwe"
    rocko = Dog.new(dog)

    expect(rocko).not_to be_valid
  end

  it "rejects names that are too short" do
    dog[:name] = "a"
    rocko = Dog.new(dog)

    expect(rocko).not_to be_valid
  end

  it "rejects display name thats too long" do
    dog[:name] = "alwklkjwlkjlkjlkjlkjlkjljlkjlkjlkjlkjlkjlkjljjelwkejlwkejlwkej
    lwekjwlekjwlekjwlkejlwkejlwkejlwkejwlekj"
    rocko = Dog.new(dog)

    expect(rocko).not_to be_valid
  end

  it "has a user" do
    rocko = Dog.create(dog)

    assert (rocko.user)
  end
end
