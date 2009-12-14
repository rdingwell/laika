require "#{File.dirname(__FILE__)}/../test_helper"
require 'builder'
require 'hdata'
require 'rexml/document'
require 'xml_helper'
class CoreTest < Test::Unit::TestCase
  
  def test_person_to_hdata
    assert false
  end
  
  context "Address model " do
     should "be able to serialize itself to xml" do 
      addr =  Address.new(:state=>"MA", :city=>"NBPT", 
                            :postal_code=>"01950" , 
                          :iso_country=>IsoCountry.find_by_code("us"), 
                          :street_address_line_one=>"line_one", 
                          :street_address_line_two=>"line_two")
      xml =  Builder::XmlMarkup.new
      str = addr.to_hdata(xml)
      add_xml = REXML::Document.new(str)
      assert XmlHelper.match_value(add_xml,"/address/city",addr.city).nil?
      assert XmlHelper.match_value(add_xml,"/address/zip",addr.postal_code).nil?
      assert XmlHelper.match_value(add_xml,"/address/stateOrProvince",addr.state).nil?
      assert XmlHelper.match_value(add_xml,"/address/streetAddress[1]",addr.street_address_line_one).nil?
      assert XmlHelper.match_value(add_xml,"/address/streetAddress[2]",addr.street_address_line_two).nil?
      assert XmlHelper.match_value(add_xml,"/address/country",addr.iso_country.code).nil?
    end
  end
  
    context "Race Model" do   
      should "be able to serialize itslef to hdata xml" do
        race = Race.new(:code=>"", :name=>"")
        xml =  Builder::XmlMarkup.new
        str = race.to_hdata(xml)
        race_xml = REXML::Document.new(str)
        assert XmlHelper.match_value(race_xml,"/race/@code" , race.code).nil?
        assert XmlHelper.match_value(race_xml,"/race/@displayName" , race.name).nil?
        assert XmlHelper.match_value(race_xml,"/race/@codeSystem" , "2.16.840.1.113883.6.238").nil?
        assert XmlHelper.match_value(race_xml,"/race/@codeSystemName" ,"CDC Race and Ethnicity").nil?
        
      end
    
    end
    
    
    context "Marital Status" do
      should "be able to serialize itslef to hdata xml" do
         ms = MaritalStatus.new(:code=>"A", :name=>"Anulled")
          xml =  Builder::XmlMarkup.new
          str = ms.to_hdata(xml)
          ms_xml = REXML::Document.new(str)
          assert XmlHelper.match_value(ms_xml,"/maritalStatus/@code" , ms.code).nil?
          assert XmlHelper.match_value(ms_xml,"/maritalStatus/@displayName" , ms.name).nil?
          assert XmlHelper.match_value(ms_xml,"/maritalStatus/@codeSystem" , "2.16.840.1.113883.5.2").nil?
          assert XmlHelper.match_value(ms_xml,"/maritalStatus/@codeSystemName" ,"HL7 MaritalStatusCode").nil?
      end
    end
    
    context "Language" do
      should "be able to serialize itslef to hdata xml" do
        
      end
    end
    
    context "Telecom" do
      should "be able to serialize itslef to hdata xml" do
      end
    end
    
    context "Gender" do
      should "be able to serialize itslef to hdata xml" do
       gen = Gender.new(:code=>"M",:name=>"Male")
       xml =  Builder::XmlMarkup.new
       str = gen.to_hdata(xml)
       gen_xml = REXML::Document.new(str)
       assert XmlHelper.match_value(gen_xml,"/gender/@code" , gen.code).nil?
       assert XmlHelper.match_value(gen_xml,"/gender/@displayName" , gen.name).nil?
       assert XmlHelper.match_value(gen_xml,"/gender/@codeSystem" , "2.16.840.1.113883.5.1").nil?
       assert XmlHelper.match_value(gen_xml,"/gender/@codeSystemName" ,"HL7 AdministrativeGenderCodes").nil?                
      end
    end
    
    context "PersonName" do
      should "be able to serialize itslef to hdata xml" do
      end
    end
    
    context "PersonLike " do
     should "be able to serialize itslef to hdata xml" do
       
     end
   end
    


  private 
  
  def assert_code_system_values(xml, root_path, attributes)
    attributes.each_pair do |attribute,value|
      error XmlHelper.match_value(xml,"#{root_path}/@#{attribute}",value).nil?
      puts error if error
      assert error.nil?
    end
  end

end