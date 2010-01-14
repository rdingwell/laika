require "#{File.dirname(__FILE__)}/../test_helper"
module Hdata
  
  class AdvanceDirectivesTest < Test::Unit::TestCase
   
    context "AdvanceDirective model" do
      should "be able to serialize itself to hdata" do
        
        p = AdvanceDirective.find(:first)
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        assert_schema_validation('advance_directive', xml.target!)
      end
    end
  
 end

end