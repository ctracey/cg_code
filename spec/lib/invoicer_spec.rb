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

      invoice = subject.invoice

      expect(invoice_item.bundles).to eq [10]
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
      {quantity: 10, code: "R12", expected_bundles: [10],                    desc: "matching bundle size"},
      {quantity: 5,  code: "R12", expected_bundles: [5],                     desc: "matching bundle size"},
      {quantity: 7,  code: "R12", expected_bundles: [10],                    desc: "inbetween bundle sizes"},
      {quantity: 3,  code: "R12", expected_bundles: [5],                     desc: "smaller than smallest bundle"},
      {quantity: 10, code: "L09", expected_bundles: [9, 3],                  desc: "bigger than largest bundle"},
      {quantity: 20, code: "R12", expected_bundles: [10, 10],                desc: "is double the largest bundle"},
      {quantity: 23, code: "R12", expected_bundles: [10, 10, 5],             desc: "more than double the largest bundle"},
      {quantity: 51, code: "R12", expected_bundles: [10, 10, 10, 10, 10, 5], desc: "thats massive"},
    ]

    scenarios.each do |scenario|
      it "returns correct bundles for order item #{scenario[:desc]}" do
        order_item = FlowerShop::OrderItem.parse("#{scenario[:quantity]} #{scenario[:code]}")
        bundles = subject.send(:calculate_bundles, order_item)
        expect(bundles).to eq scenario[:expected_bundles]
      end
    end
  end

end
