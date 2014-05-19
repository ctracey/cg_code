require 'spec_helper'

describe "FlowerSHop::BundleConfig" do

  subject { FlowerShop::BundleConfig.new("spec/fixtures/bundles.yml") }

  describe "product_config" do
    it "loads the config for an product" do
      expect(subject.product_config("R12")).to eq({5 => 6.99, 10 => 12.99})
    end

    it "returns a hash with keys sorted in descending order" do
      expect(subject.product_config("R12").keys).to eq [10, 5]
      expect(subject.product_config("R12").keys).to eq [10, 5]
    end
  end

end
