class Seed
  def initialize
    p "=============================="
    p "Seeding started"
    p "=============================="
    #generate_users
    #generate_dogs
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

  def male_names
    %w(Max Buddy Charlie Jack Cooper Rocko Toby Tucker Jake Bear Duke Teddy
    Oliver Riley Bailey Bentley Milo Buster Cody Dexter Winston Murphy Leo
    Lucky Oscar Louie Zeus Henry Sam Harley Baxter Gus Sammy Jackson).shuffle[0]
  end

  def female_names
    %w(Bella Lucy Daisy Molly Lola Sophie Sadie Maggie Chloe Bailey Roxy Zoey
    Lily Luna Coco Stella Gracie Abby Penny Zoe Ginger Ruby Rosie Lilly Ellie
    Mia Sasha Lulu Pepper Nala Lexi Lady Emma Riley).shuffle[0]
  end

  def generate_users
    100.times do |i|
      first_name = Faker::Name.first_name
      user = User.create!(
      provider:   "facebook",
      uid: i,
      oauth_token: "abc",
      first_name:   first_name,
      last_name:    Faker::Name.last_name,
      email:        "#{first_name}@email.com",
      image_url:    image.shuffle[0]
      )
      puts "User #{i}: #{user.first_name} - #{user.email} created!"
    end
  end

  def generate_dogs
    50.times do |i|
      dog = Dog.create!(
      user_id:  i + 1 ,
      name:     male_names,
      age:      Selector.age.shuffle[0],
      size:     Selector.size.shuffle[0],
      breed:    Selector.breed.shuffle[0],
      gender:   Selector.gender[0],
      zipcode:  Selector.zipcodes.shuffle[0],
      img:      "http://loremflickr.com/300/300/puppy",
      )
      puts "Dog #{i + 1}: #{dog.name} created!"
    end
    50.times do |i|
      dog = Dog.create!(
      user_id:  i + 51 ,
      name:     female_names,
      age:      Selector.age.shuffle[0],
      size:     Selector.size.shuffle[0],
      breed:    Selector.breed.shuffle[0],
      gender:   Selector.gender[1],
      zipcode:  Selector.zipcodes.shuffle[0],
      img:      "http://loremflickr.com/300/300/puppy",
      )
      puts "Dog #{i + 51}: #{dog.name} created!"
    end
  end

  def generate_observations
    25.times do |n|
      25.times do |i|
        Observation.create(
        observer_id: 2*i,
        observed_id: 299 + i,
        liked: true,
        distance: rand(9) )
        puts "It's a match for Dog with Id: #{(100 + i)}"
      end
    end
  end
end

Seed.new
