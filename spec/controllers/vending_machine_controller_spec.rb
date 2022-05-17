require_relative "../support/json_helper"
require_relative "../../controllers/vending_machine_controller"
require_relative "../../services/calculate_change_service"
require_relative "../../repositories/coin_repository"
require_relative "../../repositories/product_repository"

describe "VendingMachineController", :vending_machine_controller do
  let(:coins) {
    [
      { value: 0.25, quantity: 10 },
      { value: 0.5, quantity: 10 },
      { value: 1.0, quantity: 4 },
      { value: 2.0, quantity: 1 },
      { value: 5.0, quantity: 1 },
    ]
  }

  let(:coin_path) { "spec/support/coins.json" }
  let(:coin_repository) { CoinRepository.new(coin_path) }

  let(:products) { [{ name: "cola", price: 1.0, quantity: 1 }] }
  let(:products_path) { "spec/support/products.json" }
  let(:product_repository) { ProductRepository.new(products_path) }

  let(:attributes) {
    {
      product_repository: product_repository,
      coin_repository: coin_repository,
    }
  }

  let(:controller) {
    VendingMachineController.new(attributes[:product_repository], attributes[:coin_repository])
  }

  let(:chosen_product) { products[0] }
  let(:chosen_coin) { Coin::DENOMINATIONS[0] }

  before(:each) do
    JsonHelper.write_json(coin_path, coins)
    JsonHelper.write_json(products_path, products)
  end

  it "should be initialized with product and coin repositories" do
    expect(controller).to be_a(VendingMachineController)
  end

  describe "#make_purchase" do
    it "should update its coins" do
      repo = controller.instance_variable_get(:@coin_repository)
      quantity = repo.all[chosen_coin].quantity + (chosen_product[:price] / repo.all[chosen_coin].value)
      allow_any_instance_of(Object).to receive(:gets).and_return("0")

      controller.make_purchase

      expect(repo.all[chosen_coin].quantity).to eq(quantity)
    end

    it "should update its product stock" do
      repo = controller.instance_variable_get(:@product_repository)
      allow_any_instance_of(Object).to receive(:gets).and_return("0")
      quantity = repo.all.first.quantity - 1

      controller.make_purchase

      expect(repo.all.first.quantity).to eq(quantity)
    end

    it "should display the purchased product and change" do
      allow_any_instance_of(Object).to receive(:gets).and_return("0")

      expect { controller.make_purchase }.to output(/.+Succesfull Purchase.+/m).to_stdout_from_any_process
    end

    describe "when the product is not in stock" do
      it "should display an error message" do
        allow_any_instance_of(Object).to receive(:gets).and_return("0")
        repo = controller.instance_variable_get(:@product_repository)
        product = repo.all.first
        product.quantity = 0

        expect { controller.make_purchase }.to output(/.+Unsuccesfull Purchase.+/m).to_stdout_from_any_process
      end
    end
  end
end
