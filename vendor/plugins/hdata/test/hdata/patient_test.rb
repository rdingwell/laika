require "#{File.dirname(__FILE__)}/../test_helper"
require 'validation'
module Hdata
  
  class PatientTest < Test::Unit::TestCase
   VALIDATOR = Validators::Schema::Validator.new("patient data validator", "#{::HDATA_SCHEMA_DIRECTORY}/2009/06/patient.xsd")
    context "Patient model" do
      should "be able to serialize itself to hdata" do
        
        p = ::Patient.find_by_name("Joe Smith")
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        puts xml.target!
        errors = VALIDATOR.validate(nil,xml.target!)
        puts errors.map{|e| e.error_message} if !errors.empty?
        assert errors.empty?
      end
    end
  
 end

end