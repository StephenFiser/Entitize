RSpec.describe Entitize::Entity do
  it "converts a hash into an object based on naming" do
    dog = { name: "Fred", breed: "Husky" }
    dog = entitize(dog, "Dog")
    expect(dog).to be_a Dog
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

  it "creates nested classes with singular names" do
    dog = { name: "Fred", breed: "Husky", friends: [{ name: "DJ Kalid" }, { name: "Jimbob" }]}
    dog = entitize(dog, "Dog")
    expect(dog.friends.first).to be_a Friend
  end

  it "will use defined classes if found" do
    dog = { name: "Fred", breed: "Husky", groups: [{ name: "Yoga Klass" }]}
    dog = entitize(dog, "Dog")
    expect(dog.groups.first).to be_a Group
  end
end

def entitize(data, class_name)
  Entitize::Entity.generate(data, class_name)
end

# If a class is found, the recursive call to #generate stops
# --> we need to offer utility methods to make the continuation easier
class Group
  def initialize(data)
    @name = data[:name]
  end
end
