require 'spec_helper'

describe "FlowerShop::Invoicer" do

  let(:order_item) { double(FlowerShop::OrderItem, quantity: 10, code: "R12") }
  let(:order_items) { [order_item] }
  let(:order)       { double(FlowerShop::Order, items: order_items ) }

  subject { FlowerShop::Invoicer.new(order) }

  describe "#invoice" do
    context "multiple items" do
      let(:order_item2) { double(FlowerShop::OrderItem, quantity: 2, code: "R12") }
      let(:order_items) { [order_item, order_item2] }

      it "returns an invoice representing all the order items" do
        invoice = subject.invoice
        expect(invoice.items.size).to eq 2
      end
    end

    it "calculates the required bundles for each invoice item" do
      invoice_item = FlowerShop::InvoiceItem.new(order_item)
      allow(FlowerShop::InvoiceItem).to receive(:new) { invoice_item }

      calculated_bundles = double(FlowerShop::Bundles)
      expect(subject).to receive(:calculate_bundles).with(order_item) { calculated_bundles }

      invoice = subject.invoice

      expect(invoice_item.bundles).to eq calculated_bundles
    end
  end

  describe "#load_bundle_config" do
    it "returns a hash representing the config file" do
      order = double(FlowerShop::Order)
      invoicer = FlowerShop::Invoicer.new(order)

      bundles = invoicer.send(:load_bundle_config)

      expect(bundles.keys).to include("R12")
      expect(bundles.keys).to include("L09")
      expect(bundles.keys).to include("T58")
    end
  end

  describe "#calculate_bundles" do
    scenarios = [
      {quantity: 10, code: "R12", expected_bundles: {10 => 1},         desc: "matching bundle size"},
      {quantity: 5,  code: "R12", expected_bundles: {5 => 1},          desc: "matching bundle size"},
      {quantity: 7,  code: "R12", expected_bundles: {10 => 1},         desc: "inbetween bundle sizes"},
      {quantity: 3,  code: "R12", expected_bundles: {5 => 1},          desc: "smaller than smallest bundle"},
      {quantity: 10, code: "L09", expected_bundles: {9 => 1, 3 => 1},  desc: "bigger than largest bundle"},
      {quantity: 20, code: "R12", expected_bundles: {10 => 2},         desc: "is double the largest bundle"},
      {quantity: 23, code: "R12", expected_bundles: {10 => 2, 5 => 1}, desc: "more than double the largest bundle"},
      {quantity: 51, code: "R12", expected_bundles: {10 => 5, 5 => 1}, desc: "thats massive"},
    ]

    scenarios.each do |scenario|
      it "returns correct bundles for order item #{scenario[:desc]}" do
        order_item = FlowerShop::OrderItem.parse("#{scenario[:quantity]} #{scenario[:code]}")
        bundles = subject.send(:calculate_bundles, order_item)

        scenario[:expected_bundles].each_pair do |bundle, quantity|
          expect(bundles.bundles[bundle][:quantity]).to eq quantity
        end
      end
    end
  end

end
