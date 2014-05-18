require 'spec_helper'

describe "FlowerShop::Invoicer" do

  describe "#invoice" do
    it "returns an invoice representing all the order items" do
      order_item1 = double(FlowerShop::OrderItem, quantity: 1, code: "R11")
      order_item2 = double(FlowerShop::OrderItem, quantity: 2, code: "R12")
      order_items = [order_item1, order_item2]
      order = double(FlowerShop::Order, items: order_items )

      invoicer = FlowerShop::Invoicer.new(order)
      invoice = invoicer.invoice

      expect(invoice.items.size).to eq 2
    end
  end

end
