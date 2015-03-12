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

  def dog_names
    %w(Max Buddy Charlie Jack Cooper Rocko Toby Tucker Jake Bear Duke Teddy Oliver Riley Bailey
    Bentley Milo Buster Cody Dexter Winston Murphy Leo Lucky Oscar Louie Zeus Henry
    Sam Harley Baxter Gus Sammy Jackson Bella Lucy Daisy Molly Lola Sophie Sadie Maggie
    Chloe Bailey Roxy Zoey Lily Luna Coco Stella Gracie Abby Penny Zoe Ginger Ruby Rosie
    Lilly Ellie Mia Sasha Lulu Pepper Nala Lexi Lady Emma Riley)
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
    99.times do |i|
      dog = Dog.create!(
      user_id: i + 1 ,
      name: dog_names.shuffle[0],
      age: rand(10) + 1,
      weight: rand(50) + 10,
      breed: ["lab", "poodle", "golden"].shuffle.first,
      gender: ["male", "female"].shuffle.first,
      street: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zipcode: Faker::Address.zip_code,
      img: "http://loremflickr.com/300/300/puppy"
      )
      puts "Dog #{i}: #{dog.name} created!"
    end
  end

  def generate_observations
    25.times do |i|
      Observation.create(observer_id: 2*i, observed_id: Dog.first.id, liked: true )
    end
    puts "It's a match for Dog.last.name"
  end
end

Seed.new
