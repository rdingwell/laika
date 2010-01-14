require "#{File.dirname(__FILE__)}/../test_helper"
module Hdata
  
  class PatientTest < Test::Unit::TestCase
 
    context "Patient model" do
      should "be able to serialize itself to hdata" do
        
        p = ::Patient.find_by_name("Joe Smith")
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        assert_schema_validation('patient', xml.target!)
      end
    end
  
 end

end