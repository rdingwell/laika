require "#{File.dirname(__FILE__)}/../test_helper"
module Hdata
  
  class ConditionTest < Test::Unit::TestCase
   
    context "Condtion model" do
      should "be able to serialize itself to hdata" do
        
        p = Condition.find(:first)
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        assert_schema_validation('condition', xml.target!)
      end
    end
  
 end

end