require 'clamp'

module FlowerShop
  class CLI < Clamp::Command

    parameter "ORDER_PATH", "Path to order file"

    def execute
      begin
        puts "running Flower Shop Invoicer"

        #generate invoce
        order_invoicer = Invoicer.new(order)
        invoice = order_invoicer.invoice

        #print the invoice
        puts invoice
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
