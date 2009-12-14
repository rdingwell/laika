require "#{File.dirname(__FILE__)}/test_helper"

class HdataControllerTest < ActionController::IntegrationTest

  def setup
      @controller = HdataController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
    end

    

  
  
  context "the root hData url" do
      should "not allow a get" do
        get "/hdata/"
       assert_response 405
      end


      should "not allow a PUT" do
        puts put "/hdata/"
        assert_response 405
      end

      should "not allow a post" do
         post "/hdata/", {:type => 'extension'}
         assert_response 405
      end
    end
  
      
  context "The root of an hData Record" do
    
    should "return a response to a GET request" do
      patient = Patient.find_by_name("Joe Smith")
      get "/hdata/#{patient.id}"
      assert_response 200
    end
    
    
    should "not allow a PUT" do
      patient = Patient.find_by_name("Joe Smith")
      put "/hdata/#{patient.id}"
      assert_response 405
    end
    
    should "not allow a post as it is not supported by this addapter" do
      patient = Patient.find_by_name("Joe Smith")   
      post "/hdata/#{patient.id}", {:type => 'extension'}
      assert_response 405
    end
    
  should "provide a root.xml document describing the extensions and sections" do
        
        patient = Patient.find_by_name("Joe Smith")
       
        puts patient.inspect
        get "/hdata/#{patient.id}/root.xml"
        puts @response.body
        assert_response 200
        # doc = Nokogiri::XML.parse(last_response.body)
        #        extension_element = doc.xpath('//hrf:root/hrf:extensions/hrf:extension[text()="http://projecthdata.org/hdata/schemas/2009/06/allergy"]', 
        #                                     {'hrf' => "http://projecthdata.org/hdata/schemas/2009/06/core"})
        #        assert !extension_element.empty?
        #        section_element = doc.xpath('//hrf:root/hrf:sections/hrf:section[@name="Allergies"]', {'hrf' => "http://projecthdata.org/hdata/schemas/2009/06/core"})
        #        assert !section_element.empty?
      end
    end  
   
end
