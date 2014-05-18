require 'spec_helper'

describe "FlowerShop::CLI" do

  subject { FlowerShop::CLI.new("spec/fixtures/order.txt") }

  describe "#execute" do
    let(:invoicer) { double("Invoicer") }

    before do
      allow(FlowerShop::Order).to receive(:new) { double("Order") }
    end

    it "creates and invoice for the order" do
      allow(FlowerShop::Invoicer).to receive(:new) { invoicer }
      allow(STDOUT).to receive(:puts)
      expect(invoicer).to receive(:invoice)

      subject.execute()
    end

    it "prints the invoice" do
      invoice = "INVOICE"
      invoicer = double(FlowerShop::Invoicer, invoice: invoice)
      allow(FlowerShop::Invoicer).to receive(:new) { invoicer }

      STDOUT.should_receive(:puts).with('running Flower Shop Invoicer')
      STDOUT.should_receive(:puts).with(invoice)

      subject.execute()
    end

    it "handles errors" do
      STDOUT.should_receive(:puts).with('running Flower Shop Invoicer')
      STDOUT.should_receive(:puts).with("ERROR bad stuff happened")

      allow(FlowerShop::Order).to receive(:new).and_raise("bad stuff happened")
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
