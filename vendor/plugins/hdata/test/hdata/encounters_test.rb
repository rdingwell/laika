require "#{File.dirname(__FILE__)}/../test_helper"
module Hdata
  
  class EncounterTest < Test::Unit::TestCase
   
    context "Encounter model" do
      should "be able to serialize itself to hdata" do
        
        p = Encounter.find(:first)
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        assert_schema_validation('encounter', xml.target!)
      end
    end
  
 end

end