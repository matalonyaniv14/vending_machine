require_relative "base_view"

class VendingMachineView < BaseView
  def successfull_purchase(product, inserted, credited)
    change = credited.tally.map { |a, v| "#{a}*#{v}" }.join(" ")
    puts "---- Succesfull Purchase ----"
    puts "You payed #{inserted.sum} for #{product.name} and received #{change} for a total of #{credited.sum} change"
  end

  def invalid_change
    unsuccesfull_purchase
    puts "unable to return change, please insert different denominations"
  end

  def product_not_available
    unsuccesfull_purchase
    puts "product not in stock, please try a different product"
  end

  def unsuccesfull_purchase
    puts "-**-  Unsuccesfull Purchase -**-"
    puts "Sorry, your purchase has failed"
  end
end
