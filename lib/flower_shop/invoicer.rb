module FlowerShop
  class Invoicer
    def initialize(order)
      @order = order
    end

    def invoice
      invoice = Invoice.new
      @order.items.each do |item|
        invoice_item = InvoiceItem.new(item)
        invoice.add_item(invoice_item)
      end

      return invoice
    end

  end
end
