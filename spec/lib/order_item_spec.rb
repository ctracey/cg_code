require 'spec_helper'

describe "FlowerShop::OrderItem" do

  let(:order_text) { "10 R12" }

  describe "#parse" do

    it "returns an OrderItem" do
      order_item = FlowerShop::OrderItem.parse(order_text)
      expect(order_item.class).to eq FlowerShop::OrderItem
    end

    it "parses the order quantity" do
      order_item = FlowerShop::OrderItem.parse(order_text)
      expect(order_item.quantity).to eq 10
    end

    it "parses the order code" do
      order_item = FlowerShop::OrderItem.parse(order_text)
      expect(order_item.code).to eq "R12"
    end
  end
end
