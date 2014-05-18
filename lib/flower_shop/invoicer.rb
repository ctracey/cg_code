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
      quantity = order_item.quantity
      product_bundles = @bundle_config[order_item.code]
      bundles = Bundles.new(product_bundles)

      sizes = product_bundles.keys
      sizes.sort!.reverse!

      #larger than largest bundle
      largest = sizes.first
      while quantity > largest do
        bundles.add_bundle(largest)
        quantity -= largest
      end

      #smaller than smallest bundle
      if quantity < sizes.last
        bundles.add_bundle(sizes.last)
        return bundles
      end

      #within our bundle sizes
      sizes.each_with_index do |size, index|
        if quantity == size
          bundles.add_bundle(size)
          break
        elsif quantity > size
          bundles.add_bundle(sizes[index-1])
          break
        end
      end

      bundles
    end

  end
end
