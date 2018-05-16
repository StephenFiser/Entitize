RSpec.describe Entitize::Repo do
  it "passes a method along to a data source and wraps the response with entities" do
    repo = Entitize::Repo.new
    crazy_chickens = repo.find_the_crazy_ones(Chicken)
    expect(crazy_chickens.first).to be_a Entities::Chicken
    expect(crazy_chickens.first.name).to eq('Jimbob')
  end

  it "accepts a specific entity to use" do
    repo = Entitize::Repo.new
    crazy_chickens = repo.find_the_crazy_ones(Chicken, entity: "Chicklet")
    expect(crazy_chickens.first).to be_a Entities::Chicklet
    expect(crazy_chickens.first.name).to eq('Jimbob')
  end

  it "passes along an array of arguments to the data source" do
    repo = Entitize::Repo.new
    # This should be two args
    crazy_chickens = repo.find_the_sane_ones(Chicken, args: [[1,2,3], "Other stuff"], entity: "Chicklet")
    expect(crazy_chickens.first).to be_a Entities::Chicklet
    expect(crazy_chickens.first.name).to eq('Regular Bob')
  end
end

class Chicken
  def self.find_the_crazy_ones
    [
      { name: "Jimbob" },
      { name: "Hillbrick" }
    ]
  end

  def self.find_the_sane_ones(ids, something_else)
    [
      { name: "Regular Bob" }
    ]
  end
end
