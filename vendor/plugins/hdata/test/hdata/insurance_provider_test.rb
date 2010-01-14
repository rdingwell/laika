require "#{File.dirname(__FILE__)}/../test_helper"
module Hdata
  
  class InsuranceProviderTest < Test::Unit::TestCase
   
    context "InsuranceProvider model" do
      should "be able to serialize itself to hdata" do
        
        p = InsuranceProvider.find(:first)
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        assert_schema_validation('insurance_provider', xml.target!)
      end
    end
  
 end

end