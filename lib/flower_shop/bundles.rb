module FlowerShop
  class Bundles

    attr_accessor :bundles

    def initialize(product_bundles)
      @product_bundles = product_bundles
      @bundles = {}
    end

    def add_bundle(bundle_size)
      if @bundles.has_key? bundle_size
        bundle = @bundles[bundle_size]
      else
        bundle = {
          quantity: 0,
          price: @product_bundles[bundle_size]
        }
        @bundles[bundle_size] = bundle
      end

      bundle[:quantity] += 1
    end

  end
end
