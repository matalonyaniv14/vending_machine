require_relative "../../models/coin"

describe "Coin", :coin do
  let(:attributes) { { value: 1, quantity: 2 } }

  it "should return the value of the coin" do
    coin = Coin.new(attributes)
    expect(coin.value).to eq(attributes[:value])
  end

  it "should return the quantity of the coin" do
    coin = Coin.new(attributes)
    expect(coin.quantity).to eq(attributes[:quantity])
  end
end
