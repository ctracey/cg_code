require 'spec_helper'

describe "flower_shop gem" do

  it "is installed" do
    found = system 'flower_shop_invoicer -h > /dev/null'
    unless found
      puts "ERROR flower_shop gem is not installed. Try running rake ci"
      fail
    end
  end

  describe "flower_shop_invoicer command" do
    it "calculates minimum bundles for an order" do
      invoice = `flower_shop_invoicer spec/fixtures/order.txt`
      expect(invoice).to eq %{running Flower Shop Invoicer
10 R12 $12.99
  1 X 10 $12.99
15 L09 $41.90
  1 X 9 $24.95
  1 X 6 $16.95
13 T58 $26.94
  1 X 9 $16.99
  1 X 5 $9.95
}
    end
  end

end
