require "#{File.dirname(__FILE__)}/../test_helper"
module Hdata
  
  class SupportTest < Test::Unit::TestCase
   
    context "Support model" do
      should "be able to serialize itself to hdata" do
        
        p = Support.find(:first)
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        assert_schema_validation('support', xml.target!)
      end
    end
  
 end

end