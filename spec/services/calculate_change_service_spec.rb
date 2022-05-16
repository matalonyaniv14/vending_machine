require_relative "../support/json_helper"
require_relative "../../services/calculate_change_service"
require_relative "../../repositories/coin_repository"
require_relative "../../repositories/product_repository"

describe "CalculateChangeService", :calculate_change_service do
  let(:coins) {
    [
      { value: 1, quantity: 4 },
      { value: 2, quantity: 1 },
      { value: 5, quantity: 1 },
    ]
  }

  let(:coin_path) { "spec/support/coins.json" }
  let(:coin_repository) { CoinRepository.new(coin_path) }

  let(:products) { [{ name: "cola", price: 1.0, quantity: 1 }] }
  let(:products_path) { "spec/support/products.json" }
  let(:product_repository) { ProductRepository.new(products_path) }

  let(:attributes) {
    {
      inserted_coins: [5],
      product: product_repository.all.first,
      coin_repository: coin_repository,
    }
  }

  let(:invalid_change_attributes) {
    attributes.merge({ inserted_coins: [100_000] })
  }

  let(:successfull_results) { [2, 1, 1] }

  before do
    JsonHelper.write_json(coin_path, coins)
    JsonHelper.write_json(products_path, products)
  end

  it "should return its results" do
    service = CalculateChangeService.new(attributes)
    expect(service.results).to eq([])
  end

  it "should return its inserted_coins" do
    service = CalculateChangeService.new(attributes)
    expect(service.inserted_coins).to eq(attributes[:inserted_coins])
  end

  describe "#perform" do
    it "should return the smallest amount of change required" do
      service = CalculateChangeService.new(attributes)

      service.perform

      expect(service.results).to eq(successfull_results)
    end

    describe "when there is not enough change to return" do
      it "should raise an InvalidChangeError" do
        service = CalculateChangeService.new(invalid_change_attributes)

        expect { service.perform }.to raise_error(CalculateChangeService::InvalidChangeError)
      end
    end
  end
end
