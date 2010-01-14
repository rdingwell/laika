require "#{File.dirname(__FILE__)}/../test_helper"
module Hdata
  
  class MedicationTest < Test::Unit::TestCase
   
    context "Medication model" do
      should "be able to serialize itself to hdata" do
        
        p = Medication.find(:first)
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        assert_schema_validation('medication', xml.target!)
      end
    end
  
 end

end