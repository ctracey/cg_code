require 'clamp'

module FlowerShop
  class CLI < Clamp::Command

    parameter "ORDER_PATH", "Path to order file"

    def execute
      puts "running Flower Shop Invoicer"
    end

  end
end
