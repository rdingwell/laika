require "#{File.dirname(__FILE__)}/test_helper"
require "config/routes.rb"
class MedicationsSectionControllerTest < ActionController::IntegrationTest

  def setup
      @controller = MedicationsSectionController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
      @patient = Patient.find_by_name("Joe Smith")
     
 end
 
 

 
 context "medications section" do
   
   should "accept get method" do
     get  hdatum_medications_path(@patient.id)
     assert_response :success
   end
   
   should "accept get method to section.xml" do
      get  hdatum_medications_path(@patient.id)+ "/section.xml"
      assert_response :success
   end
   
   should "accept get method to a specific medication entry" do
      get  hdatum_medication_path(@patient.id,1)
      assert_response :success
   end
    
    should "accept put method to a specific medication entry" do
       put  hdatum_medication_path(@patient.id,1)
       assert_response :success
    end
   
   
 end
 
   
end