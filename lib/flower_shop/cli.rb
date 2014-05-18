require 'clamp'

module FlowerShop
  class CLI < Clamp::Command

    parameter "ORDER_PATH", "Path to order file"

    def execute
      begin
        puts "running Flower Shop Invoicer"

        order_invoicer = Invoicer.new(order)
        order_invoicer.invoice
      rescue Exception => e
        puts "ERROR #{e.message}"
      end
    end

    private

    def order
      order ||= Order.new(order_path)
      order
    end

  end
end
