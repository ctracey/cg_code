require 'spec_helper'

describe "FlowerShop::InvoiceItem" do

  subject { invoice_item = FlowerShop::InvoiceItem.new(order_item) }

  let(:order_item) { double(FlowerShop::OrderItem, quantity: 3, code: "R12") }

  describe "#initialize" do
    it "requires an order" do
      invoice_item = FlowerShop::InvoiceItem.new(order_item)
      expect(invoice_item.order_item).to eq order_item
    end
  end

  describe "#to_s" do
    before do
      bundles = double(FlowerShop::Bundles, cost: 5.0, to_s: "")
      subject.bundles = bundles
    end

    it "includes the order item quantity" do
      expect(subject.to_s).to match /^3/
    end

    it "includes the order item code" do
      expect(subject.to_s).to match /\sR12\s/
    end

    it "includes the total cost for the bundles" do
      expect(subject.to_s).to match /\$5.00$/
    end
  end

end
