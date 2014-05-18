require 'spec_helper'

describe "FlowerShop::Bundles" do

  let(:product_bundles) { {
    10 => 10.0,
    5  => 5.0
  } }

  describe "add_bundle" do
    it "increments number of bundles of that size" do
      item_bundles = FlowerShop::Bundles.new(product_bundles)
      item_bundles.add_bundle(10)
      item_bundles.add_bundle(10)

      expect(item_bundles.bundles).to eq({10 => {quantity: 2, price: 10.0}})
    end
  end

end
