require 'yaml'

module FlowerShop
  class Invoicer

    BUNDLES_CONFIG = "config/bundles.yml"

    def initialize(order)
      @order = order
      @bundle_config = BundleConfig.new(BUNDLES_CONFIG)
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

    def calculate_bundles(order_item)
      quantity = order_item.quantity

      product_bundles = @bundle_config.product_config(order_item.code)
      item_bundles = Bundles.new(product_bundles)
      descending_bundle_sizes = product_bundles.keys

      #larger than largest bundle
      largest_bundle = descending_bundle_sizes.first
      while quantity > largest_bundle do
        item_bundles.add_bundle(largest_bundle)
        quantity -= largest_bundle
      end

      #smaller than smallest bundle
      if quantity < descending_bundle_sizes.last
        item_bundles.add_bundle(descending_bundle_sizes.last)
        return item_bundles
      end

      #within our bundle sizes
      descending_bundle_sizes.each_with_index do |size, index|
        if quantity == size
          item_bundles.add_bundle(size)
          break
        elsif quantity > size
          item_bundles.add_bundle(descending_bundle_sizes[index-1])
          break
        end
      end

      item_bundles
    end

  end
end
