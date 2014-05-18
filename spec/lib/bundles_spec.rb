require 'spec_helper'

describe "FlowerShop::Bundles" do

  let(:product_bundles) { {
    10 => 10.0,
    5  => 5.0
  } }

  subject { FlowerShop::Bundles.new(product_bundles) }
  describe "add_bundle" do
    it "increments number of bundles of that size" do
      subject.add_bundle(10)
      subject.add_bundle(10)

      expect(subject.bundles).to eq({10 => {quantity: 2, price: 10.0}})
    end

    it "adds the bundle cost to the bundles total cost" do
      expect(subject.cost).to eq 0.0

      subject.add_bundle(10)
      expect(subject.cost).to eq 10.0

      subject.add_bundle(10)
      expect(subject.cost).to eq 20.0
    end
  end

  describe "to_s" do
    it "has a line for every bundle" do
      subject.add_bundle(10)
      subject.add_bundle(5)

      string = subject.to_s
      expect(string.lines.size).to eq 2
    end

    it "shows the quantity of each bundle" do
      subject.add_bundle(10)
      subject.add_bundle(10)

      string = subject.to_s
      expect(string).to match /^\t2 X 10/
    end

    it "shows the price of each bundle" do
      subject.add_bundle(5)

      string = subject.to_s
      expect(string).to match /\$5.00$/
    end
  end

end
