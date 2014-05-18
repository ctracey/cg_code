module FlowerShop
  class InvoiceItem

    attr_accessor :order_item, :bundles

    def initialize(order_item)
      @order_item = order_item
      @bundles = []
    end

    def to_s
      "#{@order_item.quantity} #{@order_item.code}"
    end
  end
end
