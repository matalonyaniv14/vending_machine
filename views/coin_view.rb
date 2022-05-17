require_relative "base_view"

class CoinView < BaseView
  def display_inserted_coins(coins)
    puts "Inserted coins: #{coins}"
  end

  def display_coins(coins)
    puts "---- Coins ----"
    display(coins)
  end

  def ask_for_coin
    ask_for_index("coin")
  end
end
