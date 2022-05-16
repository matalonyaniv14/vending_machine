class Router
  def initialize(controller)
    @controller = controller
    @running = false
  end

  def run!
    return if @running

    @running = true
    while @running
      display_actions
      route(user_choice)
    end
  end

  def quit!
    @running = false
  end

  private

  def display_actions
    puts "------ Vending Machine ------"
    puts "1) make a purchase"
    puts "q) quit"
  end

  def route(choice)
    case choice
    when "1" then @controller.make_purchase
    when "q" then quit!
    end
  end

  def user_choice
    gets.chomp!.downcase
  end
end
