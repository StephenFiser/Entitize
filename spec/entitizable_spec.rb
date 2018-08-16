RSpec.describe Entitize::Entitizable do
  it "converts a hash into an object based on naming" do
    dog = { name: "Fred", breed: "Husky" }
    dog = entitize(dog, "Dog")
    expect(dog).to be_a Entitize.base_class::Dog
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
    expect(dog.people.first).to be_a Entitize.base_class::Person
  end

  it "creates nested classes with singular names" do
    dog = { name: "Fred", breed: "Husky", friends: [{ name: "DJ Kalid" }, { name: "Jimbob" }]}
    dog = entitize(dog, "Dog")
    expect(dog.friends.first).to be_a Entitize.base_class::Friend
  end

  it "creates nested classes with singular names even when top class is defined" do
    dog = { name: "Fred", breed: "Husky", friends: [{ name: "DJ Kalid" }, { name: "Jimbob" }]}
    dog = entitize(dog, "Squirrel")
    expect(dog.friends.first).to be_a Entitize.base_class::Friend
  end

  it "creates nested classes with singular names even when all classes is defined" do
    dog = { name: "Fred", breed: "Husky", Bikers: [{ name: "DJ Kalid" }, { name: "Jimbob" }]}
    dog = entitize(dog, "Squirrel")
    expect(dog.Bikers.first).to be_a Entitize.base_class::Biker
    expect(dog.Bikers.first.funny?).to be true
  end

  it "can handle collections at the top level" do
    data = [{ name: "DJ Kalid" }, { name: "Jimbob" }]
    Bikers = entitize(data, "Biker")
    expect(Bikers.first).to be_a Entitize.base_class::Biker
    expect(Bikers.first.funny?).to be true
    expect(Bikers.last).to be_a Entitize.base_class::Biker
    expect(Bikers.last.funny?).to be true
  end

  it "can handle single objects that need to be created" do
    data = [{ name: "DJ Kalid" }, { name: "Jimbob", pup: { name: 'Freddy' }}]
    Bikers = entitize(data, "Biker")
    expect(Bikers.last.pup.name).to eq('Freddy')
  end

  it "will use defined classes if found" do
    dog = { name: "Fred", breed: "Husky", yeps: [{ name: "Yoga Klass" }]}
    dog = entitize(dog, "Dog")
    expect(dog.yeps.first).to be_a Entitize.base_class::Yep
  end
end

def entitize(data, class_name)
  Entitize::Classifier.generate(data, class_name)
end

# If a class is found, the recursive call to #generate stops
# --> we need to offer utility methods to make the continuation easier
class Entitize.base_class::Yep
  include Entitize::Entitizable

  def initialize(data)
    @name = data[:name]
  end
end

class Entitize.base_class::Squirrel
  include Entitize::Entitizable
end

class Entitize.base_class::Biker
  include Entitize::Entitizable

  def funny?
    true
  end

end
