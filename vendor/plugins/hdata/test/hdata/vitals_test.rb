require "#{File.dirname(__FILE__)}/../test_helper"
module Hdata
  
  class VitalsTest < Test::Unit::TestCase
   
    context "VitalSigns model" do
      should "be able to serialize itself to hdata" do
        
        p = VitalSign.find(:first)
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        assert_schema_validation('vital_signs', xml.target!)
      end
    end
  
 end

end