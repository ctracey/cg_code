module FlowerShop
  class Order

    def initialize(path)
      begin
        raise "not a txt file" if /.*\.txt$/.match(path).nil?
        @order = File.read(path)
      rescue Exception => e
        raise "Can't read order file #{path}: #{e.message}"
      end
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
