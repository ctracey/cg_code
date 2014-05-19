require 'yaml'

module FlowerShop
  class BundleConfig

    def initialize(config_path)
      @config_path = config_path
      @loaded_products = {}
    end

    def product_config(product_code)
      product_config = config[product_code]
      sorted_config = {}

      unless @loaded_products.has_key?(product_code)
        product_config.keys.sort.reverse.each do |key|
          sorted_config[key] = product_config[key]
        end

        @loaded_products[product_code] = sorted_config
      end

      @loaded_products[product_code]
    end

    private

    def config
      unless @config
        yaml = File.read(@config_path)
        @config = YAML.load(yaml)["bundles"]
      end

      @config
    end

  end
end
