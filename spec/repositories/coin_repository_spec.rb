require_relative "../support/json_helper"
require_relative "../../repositories/coin_repository"

describe "CoinRepository", :coin_repository do
  let(:coins) {
    [
      { value: 1, quantity: 1 },
      { value: 2, quantity: 1 },
      { value: 5, quantity: 1 },
    ]
  }
  let(:path) { "spec/support/coins.json" }

  before do
    JsonHelper.write_json(path, coins)
  end

  describe "#update" do
    it "should update to coins state" do
      inserted = [5]
      credited = [1, 2]
      repo = CoinRepository.new(path)
      quantity = repo.find(inserted[0]).quantity

      repo.update(inserted, credited)

      expect(repo.find(inserted[0]).quantity).to eq(quantity + 1)
    end
  end

  describe "#by_descending_value" do
    it "should return its rows sorted in ascending order" do
      repo = CoinRepository.new(path)
      max_value = coins.max_by { |coin| coin[:value] }[:value]
      min_value = coins.min_by { |coin| coin[:value] }[:value]

      sorted = repo.by_descending_value

      expect(sorted.first.value).to eq(max_value)
      expect(sorted.last.value).to eq(min_value)
    end
  end
end
