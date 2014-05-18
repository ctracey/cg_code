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
    it "includes the order item quantity" do
      expect(subject.to_s).to match /^3/
    end

    it "includes the order item code" do
      expect(subject.to_s).to match /\sR12$/
    end
  end

end
