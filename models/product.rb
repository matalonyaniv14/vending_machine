class Product
  class OutOfStockError < StandardError; end

  attr_reader :price, :name
  attr_accessor :quantity

  def initialize(args = {})
    @name = args[:name]
    @price = args[:price]
    @quantity = args[:quantity]
  end

  def in_stock?
    @quantity > 0
  end

  def to_s
    "Product: #{@name} - #{@price} - ##{@quantity}"
  end
end
