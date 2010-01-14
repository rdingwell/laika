require "#{File.dirname(__FILE__)}/../test_helper"
module Hdata
  
  class ImmunizationTest < Test::Unit::TestCase
   
    context "Immunization model" do
      should "be able to serialize itself to hdata" do
        
        p = Immunization.find(:first)
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        assert_schema_validation('immunization', xml.target!)
      end
    end
  
 end

end