module FlowerShop
  class InvoiceItem

    attr_accessor :order_item, :bundles

    def initialize(order_item)
      @order_item = order_item
    end

    def to_s
      "#{@order_item.quantity} #{@order_item.code} $#{'%.02f' % bundles.cost}\n#{bundles}"
    end
  end
end
