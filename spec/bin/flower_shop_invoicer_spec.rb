require 'spec_helper'

describe "flower shop invoicer" do

  let(:command) { "./bin/flower_shop_invoicer" }

  it "runs and logs to the console" do
    console_output = `#{command}`
    console_output.include?("running Flower Shop Invoicer").should be_true
  end

end
