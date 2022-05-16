require_relative "repositories/coin_repository"
require_relative "repositories/product_repository"

require_relative "controllers/vending_machine_controller"
require_relative "router"

COIN_PATH = "data/coins.json"
PRODUCT_PATH = "data/products.json"

coin_repo = CoinRepository.new(COIN_PATH)
product_repo = ProductRepository.new(PRODUCT_PATH)

vending_machine_controller = VendingMachineController.new(product_repo, coin_repo)

router = Router.new(vending_machine_controller)
router.run!
