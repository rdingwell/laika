require "#{File.dirname(__FILE__)}/../test_helper"
module Hdata
  
  class AllergyTest < Test::Unit::TestCase
   
    context "Allergy model" do
      should "be able to serialize itself to hdata" do
        
        p = Allergy.find(:first)
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        assert_schema_validation('allergy', xml.target!)
      end
    end
  
 end

end