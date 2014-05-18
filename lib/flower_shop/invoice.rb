module FlowerShop
  class Invoice

    attr_accessor :items

    def initialize
      @items = []
    end

    def add_item(invoice_item)
      @items << invoice_item
    end

    def to_s
      string = ""

      @items.each do |item|
        string += "#{item}\n"
      end

      string
    end

  end
end
