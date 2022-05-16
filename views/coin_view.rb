require_relative "base_view"

class CoinView < BaseView
  def display_coins(coins)
    "---- Coins ----"
    display(coins)
  end

  def ask_for_coin
    ask_for_index("coin")
  end
end
