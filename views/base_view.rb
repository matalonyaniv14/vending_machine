class BaseView
  def ask_for_index(resource = nil)
    ask_for("#{resource} index").to_i
  end

  def display(items)
    items.each_with_index do |item, idx|
      puts "#{idx}) #{item}"
    end
  end

  def ask_for(something)
    puts ">"
    puts "Please enter #{something}"
    gets.chomp
  end

  def invalid_input(message)
    puts "Input not valid, please anter a valid #{message}"
  end
end
