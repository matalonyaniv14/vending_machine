class Coin
  attr_reader :value
  attr_accessor :quantity

  DENOMINATIONS = [0.25, 0.5, 1.0, 2.0, 3.0, 5.0]

  def initialize(args = {})
    @value = args[:value]
    @quantity = args[:quantity] || 1
  end

  def to_s
    "Coin: #{@value} quantity: #{@quantity}"
  end
end
