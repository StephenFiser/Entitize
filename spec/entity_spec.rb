RSpec.describe Entitize::Entity do
  it "converts a hash into an object based on naming" do
    dog = { name: "Fred", breed: "Husky" }
    dog = entitize(dog, "Dog")
    expect(dog).to be_a Entities::Dog
  end

  it "converts each attribute in the hash to a method" do
    dog = { name: "Fred", breed: "Husky" }
    dog = entitize(dog, "Dog")
    expect(dog.name).to eq("Fred")
    expect(dog.breed).to eq("Husky")
  end

  it "creates objects for nested collection attributes" do
    dog = { name: "Fred", breed: "Husky", friends: [{ name: "DJ Kalid" }, { name: "Jimbob" }]}
    dog = entitize(dog, "Dog")
    expect(dog.friends.count).to eq(2)
    expect(dog.friends.first.name).to eq("DJ Kalid")
  end

  it "is smart about pluralization (thanks Rails)" do
    dog = { name: "Fred", breed: "Husky", people: [{ name: "DJ Kalid" }, { name: "Jimbob" }]}
    dog = entitize(dog, "Dog")
    expect(dog.people.first).to be_a Entities::Person
  end

  it "creates nested classes with singular names" do
    dog = { name: "Fred", breed: "Husky", friends: [{ name: "DJ Kalid" }, { name: "Jimbob" }]}
    dog = entitize(dog, "Dog")
    expect(dog.friends.first).to be_a Entities::Friend
  end

  it "creates nested classes with singular names even when top class is defined" do
    dog = { name: "Fred", breed: "Husky", friends: [{ name: "DJ Kalid" }, { name: "Jimbob" }]}
    dog = entitize(dog, "Pig")
    expect(dog.friends.first).to be_a Entities::Friend
  end

  it "creates nested classes with singular names even when all classes is defined" do
    dog = { name: "Fred", breed: "Husky", jokers: [{ name: "DJ Kalid" }, { name: "Jimbob" }]}
    dog = entitize(dog, "Pig")
    expect(dog.jokers.first).to be_a Entities::Joker
    expect(dog.jokers.first.funny?).to be true
  end

  it "can handle collections at the top level" do
    data = [{ name: "DJ Kalid" }, { name: "Jimbob" }]
    jokers = entitize(data, "Joker")
    expect(jokers.first).to be_a Entities::Joker
    expect(jokers.first.funny?).to be true
    expect(jokers.last).to be_a Entities::Joker
    expect(jokers.last.funny?).to be true
  end

  it "can handle single objects that need to be created" do
    data = [{ name: "DJ Kalid" }, { name: "Jimbob", pup: { name: 'Freddy' }}]
    jokers = entitize(data, "Joker")
    expect(jokers.last.pup.name).to eq('Freddy')
  end

  it "will use defined classes if found" do
    dog = { name: "Fred", breed: "Husky", groups: [{ name: "Yoga Klass" }]}
    dog = entitize(dog, "Dog")
    expect(dog.groups.first).to be_a Entities::Group
  end
end

def entitize(data, class_name)
  Entitize::Entity.generate(data, class_name)
end

# If a class is found, the recursive call to #generate stops
# --> we need to offer utility methods to make the continuation easier
class Entities::Group
  def initialize(data)
    @name = data[:name]
  end
end

class Entities::Pig < Entitize::Entity
end

class Entities::Joker < Entitize::Entity

  def funny?
    true
  end

end

# TODO:
# 4. Bring in repo concept -> Note: Don't include ApiResponse concept! These can be custom now!
