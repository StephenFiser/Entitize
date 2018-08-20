RSpec.describe Entitize::Repo do
  it "passes a method along to a data source and wraps the response with entities" do
    repo = Entitize::Repo.new
    crazy_chickens = repo.find_the_crazy_ones(Chicken)
    expect(crazy_chickens.first).to be_a Entitize.base_class::Chicken
    expect(crazy_chickens.first.name).to eq('Jimbob')
  end

  it "accepts a specific entity to use" do
    repo = Entitize::Repo.new
    crazy_chickens = repo.find_the_crazy_ones(Chicken, entity: "Chicklet")
    expect(crazy_chickens.first).to be_a Entitize.base_class::Chicklet
    expect(crazy_chickens.first.name).to eq('Jimbob')
  end

  it "passes along an array of arguments to the data source" do
    repo = Entitize::Repo.new
    # This should be two args
    crazy_chickens = repo.find_the_sane_ones(Chicken, args: [[1,2,3], "Other stuff"], entity: "Chicklet")
    expect(crazy_chickens.first).to be_a Entitize.base_class::Chicklet
    expect(crazy_chickens.first.name).to eq('Regular Bob')
  end

  it "turns token arg into token method" do
    repo = Entitize::Repo.new({ token: '12345' })
    token_chickens = repo.find_with_token(Chicken, entity: "Chicken")
    expect(token_chickens.first).to be_a Entitize.base_class::Chicken
    expect(token_chickens.first.name).to eq('Token Bob')
  end

  it "accepts a hash of args" do
    repo = Entitize::Repo.new({ token: '12345' })
    expect(repo.token).to eq('12345')
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

  def self.find_with_token(token)
    return false if token != '12345'
    [
      { name: "Token Bob" }
    ]
  end
end
