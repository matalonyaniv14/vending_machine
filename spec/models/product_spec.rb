require_relative "../../models/product"

describe "Product", :product do
  let(:attributes) { { name: "cola", price: 1.0, quantity: 0 } }

  it "should return the name of the product" do
    product = Product.new(attributes)
    expect(product.name).to eq(attributes[:name])
  end

  it "should return the price of the product" do
    product = Product.new(attributes)
    expect(product.price).to eq(attributes[:price])
  end

  it "should return the quantity of the product" do
    product = Product.new(attributes)
    expect(product.quantity).to eq(attributes[:quantity])
  end

  describe "#in_stock?" do
    it "should return false when the products quantity is 0" do
      product = Product.new(attributes)
      expect(product.in_stock?).to eq(false)
    end

    it "should return true when the products quantity is greater than 0" do
      product = Product.new(attributes)

      product.quantity = 100

      expect(product.in_stock?).to eq(true)
    end
  end
end
