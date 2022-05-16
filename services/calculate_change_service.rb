class CalculateChangeService
  class InvalidChangeError < StandardError; end

  attr_reader :results, :inserted_coins

  def initialize(args = {})
    @inserted_coins = args[:inserted_coins]
    @product = args[:product]
    @coin_repository = args[:coin_repository]
    @results = []
  end

  def perform
    required_change = @inserted_coins.sum - @product.price
    return if required_change.zero?

    change = make_change(required_change)

    if required_change == change.sum
      @results = change
      return
    end

    raise InvalidChangeError
  end

  private

  def make_change(required_change)
    @coin_repository.by_descending_value.each_with_object([]) do |coin, acc|
      value, quantity = coin.value, coin.quantity
      f = required_change / value
      next acc unless f >= 1

      if f > quantity
        next acc if quantity.zero?

        f -= quantity
        required_change -= (value * f)
      else
        required_change %= value
      end

      acc << Array.new(f) { value }
    end.flatten
  end
end
