require_relative "base_view"

class ProductView < BaseView
  def ask_for_product
    ask_for_index("product")
  end

  def display_products(products)
    puts "----- products -----"
    display(products)
  end
end
