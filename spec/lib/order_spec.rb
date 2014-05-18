require 'spec_helper'

describe "FlowerShop::Order" do

  subject { FlowerShop::Order.new("spec/fixtures/order.txt") }

  describe "#initialize" do
    it "raises an error if the order file cannot be read" do
      expect {
        FlowerShop::Order.new("made/up/path/order.txt")
      }.to raise_error "Can't read order file made/up/path/order.txt: No such file or directory - made/up/path/order.txt"
    end

    it "raises an error if the order file is not a text file" do
      nontext_file = "spec/fixtures/nontext.csv"
      expect {
        FlowerShop::Order.new(nontext_file)
      }.to raise_error "Can't read order file #{nontext_file}: not a txt file"
    end
  end

  describe "#items" do

    let(:item1) { double("item 1") }
    let(:item2) { double("item 2") }
    let(:item3) { double("item 3") }

    it "reads the order file and returns a list of items for each order line" do
      expect(FlowerShop::OrderItem).to receive(:new) { item1 }
      expect(FlowerShop::OrderItem).to receive(:new) { item2 }
      expect(FlowerShop::OrderItem).to receive(:new) { item3 }

      expect(subject.items).to eq [item1, item2, item3]
    end

  end

end
