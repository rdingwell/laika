require "#{File.dirname(__FILE__)}/../test_helper"
module Hdata
  
  class ProcedureTest < Test::Unit::TestCase
   
    context "Procedure model" do
      should "be able to serialize itself to hdata" do
        
        p = Procedure.find(:first)
        xml =  Builder::XmlMarkup.new(:indent=>2)
        p.to_hdata(xml)
        assert_schema_validation('procedure', xml.target!)
      end
    end
  
 end

end