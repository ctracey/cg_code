module FlowerShop
  class Order

    def initialize(path)
      @order = File.read(path)
    end

    def items
      @items ||= parse_items
    end

    private

    def parse_items
      items = []

      @order.split("\n").each do |item|
        items << OrderItem.parse(item)
      end

      items
    end

  end
end
