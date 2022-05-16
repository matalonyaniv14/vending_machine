require_relative "base_repository"
require_relative "../models/coin"

class CoinRepository < BaseRepository
  def update(inserted_coins, coin_change)
    inserted_coins.each { |coin| find(coin).quantity += 1 }
    coin_change.each { |coin| find(coin).quantity -= 1 }
  end

  def find(value)
    @rows.find { |data| data.value == value }
  end

  def by_descending_value
    @rows.sort_by { |coin| coin.value }.reverse
  end
end
