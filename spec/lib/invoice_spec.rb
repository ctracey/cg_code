require 'spec_helper'

describe FlowerShop::Invoice do

  describe "#add_item" do
    it "adds the item to the items collection" do
      invoice_item = double(FlowerShop::InvoiceItem)
      subject.add_item(invoice_item)

      expect(subject.items).to eq [invoice_item]
    end
  end

  describe "#to_s" do
    it "has a line for every invoice item" do
      order_item1 = double(FlowerShop::OrderItem, quantity: 1, code: "R11")
      order_item2 = double(FlowerShop::OrderItem, quantity: 2, code: "R12")
      invoice_item1 = FlowerShop::InvoiceItem.new(order_item1)
      invoice_item1.bundles = FlowerShop::Bundles.new({})
      invoice_item2 = FlowerShop::InvoiceItem.new(order_item2)
      invoice_item2.bundles = FlowerShop::Bundles.new({})

      subject.add_item(invoice_item1)
      subject.add_item(invoice_item2)

      expect(subject.to_s).to match /^1 R11 \$0.00$/
      expect(subject.to_s).to match /^2 R12 \$0.00$/
    end
  end

end
