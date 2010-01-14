require "#{File.dirname(__FILE__)}/../test_helper"
module Hdata
  
  class HealthcareProviderTest < Test::Unit::TestCase
   
    context "Healthcare model" do
      should "be able to serialize itself to hdata" do
        
        p = Provider.find(:first)
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        assert_schema_validation('healthcare_provider', xml.target!)
      end
    end
  
 end

end