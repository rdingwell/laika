require "#{File.dirname(__FILE__)}/../test_helper"
module Hdata
  
  class ResultTest < Test::Unit::TestCase
   
    context "Results model" do
      should "be able to serialize itself to hdata" do
        
        p = Result.find(:first)
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        assert_schema_validation('result', xml.target!)
      end
    end
  
 end

end