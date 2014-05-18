require 'yaml'

module FlowerShop
  class Invoicer

    BUNDLES_CONFIG = "config/bundles.yml"

    def initialize(order)
      @order = order
      @bundle_config = load_bundle_config
    end

    def invoice
      invoice = Invoice.new

      @order.items.each do |item|
        invoice_item = InvoiceItem.new(item)
        invoice_item.bundles = calculate_bundles(item)
        invoice.add_item(invoice_item)
      end

      return invoice
    end

    private

    def load_bundle_config
      yaml = File.read(Invoicer::BUNDLES_CONFIG)
      YAML.load(yaml)["bundles"]
    end

    def calculate_bundles(order_item)
      bundles = []
      quantity = order_item.quantity

      sizes = @bundle_config[order_item.code].keys
      sizes.sort!.reverse!

      largest = sizes.first
      while quantity > largest do
        bundles << largest
        quantity -= largest
      end

      #smaller than smallest bundle
      if quantity < sizes.last
        bundles << sizes.last
        return bundles
      end

      sizes.each_with_index do |size, index|
        if quantity == size
          bundles << size
          break
        elsif quantity > size
          bundles << sizes[index-1]
          break
        end
      end

      bundles
    end

  end
end
