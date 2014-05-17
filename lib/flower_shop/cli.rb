require 'clamp'

module FlowerShop
  class CLI < Clamp::Command

    parameter "ORDER_PATH", "Path to order file"

    def execute
      puts "running Flower Shop Invoicer"

      order_invoicer = Invoicer.new(order)
      order_invoicer.invoice
    end

    private

    def order
      order ||= Order.new(order_path)
      order
    end

  end
end
