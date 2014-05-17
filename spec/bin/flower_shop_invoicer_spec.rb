require 'spec_helper'

describe "flower shop invoicer" do

  let(:command) { "./bin/flower_shop_invoicer" }
  let(:order_path) { "./spec/fixtures/order.txt" }

  it "runs and logs to the console" do
    console_output = `#{command} #{order_path}`
    console_output.include?("running Flower Shop Invoicer").should be_true
  end

  context "order file parameter" do
    let(:hide_output) { " > /dev/null" }

    it "accepts the path to an order file as order parameter" do
      system("#{command} #{order_path} #{hide_output}").should be_true
    end

    context "no parameter provided" do
      it "the exit code is 1" do
        system(command).should be_false
      end
    end
  end

end
