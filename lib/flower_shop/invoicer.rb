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
      item_bundles = Bundles.new(product_bundles)

      bundle_sizes = product_bundles.keys
      bundle_sizes.sort!.reverse!

      #larger than largest bundle
      largest_bundle = bundle_sizes.first
      while quantity > largest_bundle do
        item_bundles.add_bundle(largest_bundle)
        quantity -= largest_bundle
      end

      #smaller than smallest bundle
      if quantity < bundle_sizes.last
        item_bundles.add_bundle(bundle_sizes.last)
        return item_bundles
      end

      #within our bundle sizes
      bundle_sizes.each_with_index do |size, index|
        if quantity == size
          item_bundles.add_bundle(size)
          break
        elsif quantity > size
          item_bundles.add_bundle(bundle_sizes[index-1])
          break
        end
      end

      item_bundles
    end

  end
end
