require 'spec_helper'

describe "FlowerShop::CLI" do

  subject { FlowerShop::CLI.new("path") }

  describe "#execute" do
    let(:invoicer) { double("Invoicer") }

    it "creates and invoice for the order" do
      allow(FlowerShop::Order).to receive(:new) { double("Order") }
      allow(FlowerShop::Invoicer).to receive(:new) { invoicer }
      expect(invoicer).to receive(:invoice)

      subject.execute()
    end
  end

  describe "#order" do
    let(:order) { double("Order") }

    it "creates an order from the path" do
      expect(FlowerShop::Order).to receive(:new) { order }

      expect(subject.send(:order)).to eq order
    end
  end
end
