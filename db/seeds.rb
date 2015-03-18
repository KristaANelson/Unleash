class Seed
  def initialize
    p "=============================="
    p "Seeding started"
    p "=============================="
    generate_users
    generate_dogs
    generate_observations
    p "=============================="
    p "Seed data loaded"
    p "=============================="
  end

  def image
    [ "http://cdn03.cdn.justjared.com/wp-content/uploads/headlines/2014/12/ryan-gosling-lost-rivers-hit-theaters.jpg",
      "http://i.forbesimg.com/media/lists/people/taylor-swift_416x416.jpg",
      "http://the305.com/blog/wp-content/uploads/2014/01/justin-bieber-arrested-miami-DIU.jpg",
      "http://atlantablackstar.com/wp-content/uploads/2014/03/oprah-winfrey-167024_w1000.jpg"]
  end

  def age
    ["Puppy: Less than a year", "Young: 1yr - 2yr", "Adult: 2yrs - 9yrs", "Senior: 10yrs and older"].shuffle.first
  end

  def size
    ["Tiny: Less than 10 lbs", "Small: 10lbs - 30lbs", "Medium: 30lbs - 50lbs", "Large: Over 50lbs"].shuffle.first
  end

  def male_names
    %w(Max Buddy Charlie Jack Cooper Rocko Toby Tucker Jake Bear Duke Teddy Oliver Riley Bailey
    Bentley Milo Buster Cody Dexter Winston Murphy Leo Lucky Oscar Louie Zeus Henry
    Sam Harley Baxter Gus Sammy Jackson).shuffle[0]
  end

  def female_names
    %w(Bella Lucy Daisy Molly Lola Sophie Sadie Maggie
    Chloe Bailey Roxy Zoey Lily Luna Coco Stella Gracie Abby Penny Zoe Ginger Ruby Rosie
    Lilly Ellie Mia Sasha Lulu Pepper Nala Lexi Lady Emma Riley).shuffle[0]
  end

  def generate_users
    100.times do |i|
      user = User.create!(
      provider: "facebook",
      uid: i,
      oauth_token: "abc",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      image_url: image.shuffle[0]
      )
      puts "User #{i}: #{user.first_name} - #{user.email} created!"
    end
  end

  def generate_dogs
    20.times do |i|
      dog = Dog.create!(
      user_id: i + 1 ,
      name: male_names,
      age: age,
      weight: size,
      breed: ["lab", "poodle", "golden"].shuffle.first,
      gender: "Male",
      street: "",
      city: "Denver",
      state: "C0",
      zipcode: "8020" + (rand(9) + 1).to_s,
      img: "http://loremflickr.com/300/300/puppy",
      )
      puts "Dog #{i + 1}: #{dog.name} created!"
    end
    18.times do |i|
      dog = Dog.create!(
      user_id: i + 51 ,
      name: female_names,
      age: age,
      weight: size,
      breed: ["lab", "poodle", "golden"].shuffle.first,
      gender: "Female",
      street: "",
      city: "Denver",
      state: "C0",
      zipcode: "802" + (rand(11) + 1).to_s,
      img: "http://loremflickr.com/300/300/puppy",
      )
      puts "Dog #{i + 51}: #{dog.name} created!"
    end
  end

  def generate_observations
    25.times do |i|
      Observation.create(dog_id: 2*i, observed_id: Dog.first.id, liked: true )
    puts "It's a match for #{Dog.first.name}"
    end
  end
end

Seed.new
