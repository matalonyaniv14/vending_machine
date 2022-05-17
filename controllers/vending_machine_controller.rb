require_relative "../views/vending_machine_view"
require_relative "../views/product_view"
require_relative "../views/coin_view"
require_relative "../models/coin"
require_relative "../services/calculate_change_service"

class VendingMachineController
  def initialize(product_repository, coin_repository)
    @product_repository = product_repository
    @coin_repository = coin_repository

    @vending_machine_view = VendingMachineView.new
    @product_view = ProductView.new
    @coin_view = CoinView.new
  end

  def make_purchase
    @coin_view.display_coins(@coin_repository.all)
    begin
      product = choose_product
      inserted_coins = accept_coins(product.price)
      change_service = calculate_change(inserted_coins, product)
    rescue Product::OutOfStockError
      @vending_machine_view.product_not_available
      return
    rescue CalculateChangeService::InvalidChangeError
      @vending_machine_view.invalid_change
      return
    end

    @coin_repository.update(inserted_coins, change_service.results)
    product.quantity -= 1

    @vending_machine_view.successfull_purchase(product, inserted_coins, change_service.results)
  end

  private

  def accept_coins(total)
    inserted_coins = []
    while inserted_coins.sum < total
      coin = choose_coin
      next if coin.nil?

      inserted_coins << coin
      @coin_view.display_inserted_coins(inserted_coins)
    end
    inserted_coins
  end

  def choose_product
    @product_view.display_products(@product_repository.all)
    product_idx = @product_view.ask_for_product

    product = @product_repository.all[product_idx]
    return product if product && product.in_stock?

    raise Product::OutOfStockError
  end

  def choose_coin
    @coin_view.display_coins(Coin::DENOMINATIONS)
    coin_idx = @coin_view.ask_for_coin
    Coin::DENOMINATIONS[coin_idx]
  end

  def calculate_change(inserted_coins, product)
    service = CalculateChangeService.new(
      inserted_coins: inserted_coins,
      product: product,
      coin_repository: @coin_repository,
    )
    service.perform
    service
  end
end
