module FlowerShop
  class OrderItem

    attr_accessor :quantity, :code

    def self.parse(order_text)
      raise "Invalid order item: #{order_text}" if /^[0-9]* [A-Z][0-9]*$/.match(order_text).nil?

      quantity = /^[0-9]* /.match(order_text).to_s.to_i
      code = /[a-zA-Z0-9]*$/.match(order_text).to_s
      OrderItem.new(quantity, code)
    end

    private

    def initialize(quantity, code)
      @quantity = quantity
      @code = code
    end

  end
end
