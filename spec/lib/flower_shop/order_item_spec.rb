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

    context "invalid order item" do
      let(:order_text) { "R12" }

      it "raises an error for invalid order items" do
        expect {
          FlowerShop::OrderItem.parse(order_text)
        }.to raise_error "Invalid order item: #{order_text}"
      end
    end
  end

  describe "#to_s" do
    it "returns a string including quantity and code" do
      order_item = FlowerShop::OrderItem.parse("15 T05")
      expect(order_item.to_s).to eq "15 T05"
    end
  end
end
