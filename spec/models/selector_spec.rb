require 'rails_helper'

RSpec.describe Selector, :type => :model do
    it "has a list of breeds" do
    assert  Selector.breed_list.include?("poodle")
    end

    it "has an age list" do
      assert  Selector.age_list.include?("Puppy: Less than a year")
    end

    it "is has a gender_list" do
      assert  Selector.gender_list.include?("Male")
    end

    it "is has a zipcodes_list" do
      assert  Selector.zipcodes.include?("80218")
    end
  end
