RSpec.describe "Entire Workflow" do

  class Entities::Kangaroo
    include Entitize::Entitizable

    class << self

      def find
        {
          name: "Jeff",
          beers: [
            {
              name: "Foster's",
              description: "Austrian for 'beer'",
              facts: [
                { content: "Australians don't really drink it." },
                { content: "It's more popular in Europe." }
              ]
            }
          ]
        }
      end

    end
  end

  class Entities::Beer
    include Entitize::Entitizable
  end

  it "properly constructs classes based on a given dataset (using repo)" do
    repo = Entitize::Repo.new
    jeff = repo.find(Entities::Kangaroo)
    expect(jeff.name).to eq("Jeff")
    expect(jeff.beers.count).to eq(1)

    fosters = jeff.beers.first
    expect(fosters.name).to eq("Foster's")
    expect(fosters.facts.first).to be_a(Entities::Fact)
    expect(fosters.facts.first.content).to eq("Australians don't really drink it.")
  end

  it "properly constructs classes based on a given dataset (w/o repo)" do
    data = Entities::Kangaroo.find()
    jeff = Entities::Kangaroo.auto_new(data)
    expect(jeff.name).to eq("Jeff")
    expect(jeff.beers.count).to eq(1)

    fosters = jeff.beers.first
    expect(fosters.name).to eq("Foster's")
    expect(fosters.facts.first).to be_a(Entities::Fact)
    expect(fosters.facts.first.content).to eq("Australians don't really drink it.")
  end

end
