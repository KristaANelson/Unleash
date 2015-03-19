require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user)  { User.new(first_name: "Krista") }

  let(:dog)     { { name: "Rocko",
                   age: Selector.age.first,
                   size: Selector.size.first,
                   zipcode: 80218,
                   gender: "Male",
                   breed: "poodle",
                   user_id: user.id} }

  it "it can have a first_name" do
    expect(user).to be_valid
  end

  it "it can have a last_name" do
    user.last_name = "Nelson"

    expect(user).to be_valid
  end

  it "is has dogs" do
    user.save

    assert_equal [], user.dogs
  end
end
