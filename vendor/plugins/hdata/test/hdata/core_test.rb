require "#{File.dirname(__FILE__)}/../test_helper"
require 'builder'
require 'hdata'


class CoreTest < Test::Unit::TestCase
  

  
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
      assert_xml_match(add_xml,"/address/city",addr.city).nil?
      assert_xml_match(add_xml,"/address/zip",addr.postal_code).nil?
      assert_xml_match(add_xml,"/address/stateOrProvince",addr.state).nil?
      assert_xml_match(add_xml,"/address/streetAddress[1]",addr.street_address_line_one).nil?
      assert_xml_match(add_xml,"/address/streetAddress[2]",addr.street_address_line_two).nil?
      assert_xml_match(add_xml,"/address/country",addr.iso_country.code).nil?
    end
  end
  
    context "Race Model" do   
      should "be able to serialize itslef to hdata xml" do
        race = Race.new(:code=>"", :name=>"")
        xml =  Builder::XmlMarkup.new
        str = race.to_hdata(xml)
        race_xml = REXML::Document.new(str)
        assert_xml_match(race_xml,"/race/@code" , race.code).nil?
        assert_xml_match(race_xml,"/race/@displayName" , race.name).nil?
        assert_xml_match(race_xml,"/race/@codeSystem" , "2.16.840.1.113883.6.238").nil?
        assert_xml_match(race_xml,"/race/@codeSystemName" ,"CDC Race and Ethnicity").nil?
        
      end
    
    end
    
    
    context "Marital Status" do
      should "be able to serialize itslef to hdata xml" do
         ms = MaritalStatus.new(:code=>"A", :name=>"Anulled")
          xml =  Builder::XmlMarkup.new
          str = ms.to_hdata(xml)
          ms_xml = REXML::Document.new(str)
          assert_xml_match(ms_xml,"/maritalStatus/@code" , ms.code)
          assert_xml_match(ms_xml,"/maritalStatus/@displayName" , ms.name)
          assert_xml_match(ms_xml,"/maritalStatus/@codeSystem" , "2.16.840.1.113883.5.2")
          assert_xml_match(ms_xml,"/maritalStatus/@codeSystemName" ,"HL7 MaritalStatusCode")
      end
    end
    
    context "Language" do
      should "be able to serialize itslef to hdata xml" do
        lang = Language.new(:iso_language=> IsoLanguage.new(:code=>"en"),
                            :iso_country=>IsoCountry.new(:code=>"gb"))
        xml =  Builder::XmlMarkup.new
        str = lang.to_hdata(xml)
        doc = REXML::Document.new(str)

        assert_xml_match(doc,"/language/@code" , lang.iso_language.code+ "-" + lang.iso_country.code)
        assert_xml_match(doc,"/language/@displayName" , nil)
        assert_xml_match(doc,"/language/@codeSystem" , "NA")
        assert_xml_match(doc,"/language/@codeSystemName" ,"NA")

        
      end
    end
    
    context "Telecom" do
      should "be able to serialize itslef to hdata xml" do
        tel = Telecom.new
        tel.randomize
        xml =  Builder::XmlMarkup.new
        # need to wrap the telecom objects as the just dump out a list with no root node
        str = xml.root do
         tel.to_hdata(xml)
        end
        doc = REXML::Document.new(str)

        if tel.home_phone
          assert_xml_match(doc,"/root/telecom[@use='home' and  @value='#{tel.home_phone}']/@type", "phone-landline",{},{},:long).nil?  
        end
        if tel.work_phone
          assert_xml_match(doc.root,"/root/telecom[@use='work'  and @value='#{tel.work_phone}']/@type", "phone-landline").nil? 

        end
        if tel.mobile_phone
          assert_xml_match(doc.root,"/root/telecom[@use='other'  and @value='#{tel.mobile_phone}']/@type", "phone-cell").nil? 

        end
        if tel.vacation_home_phone
          assert_xml_match(doc,"/root/telecom[@use='other'  and @value='#{tel.vacation_home_phone}']/@type", "phone-landline").nil?
        end
        if tel.email
          assert_xml_match(doc,"/root/telecom[@use='other'  and @value='#{tel.email}']/@type", "email").nil? 
        end
        if tel.url
          assert_xml_match(doc,"/root/telecom[@use='other'  and @value='#{tel.url}']/@type", "other").nil? 
        end
      end
    end
    
    context "Gender" do
      should "be able to serialize itslef to hdata xml" do
       gen = Gender.new(:code=>"M",:name=>"Male")
       xml =  Builder::XmlMarkup.new
       str = gen.to_hdata(xml)
       gen_xml = REXML::Document.new(str)
       assert_xml_match(gen_xml,"/gender/@code" , gen.code).nil?
       assert_xml_match(gen_xml,"/gender/@displayName" , gen.name).nil?
       assert_xml_match(gen_xml,"/gender/@codeSystem" , "2.16.840.1.113883.5.1").nil?
       assert_xml_match(gen_xml,"/gender/@codeSystemName" ,"HL7 AdministrativeGenderCodes").nil?                
      end
    end
    
    context "PersonName" do
      should "be able to serialize itslef to hdata xml" do
        pn = PersonName.new(:name_prefix=>"pre", :first_name=>"first",:last_name=>"last",:middle_name=>"middle",:name_suffix=>"suf")
        xml =  Builder::XmlMarkup.new
        str = pn.to_hdata(xml)
        pn_xml =  REXML::Document.new(str)
        
        assert_xml_match(pn_xml,"/name/given[1]",pn.first_name)
        assert_xml_match(pn_xml,"/name/given[2]",pn.middle_name)
        assert_xml_match(pn_xml,"/name/lastname",pn.last_name)
        assert_xml_match(pn_xml,"/name/suffix",pn.name_suffix)
        assert_xml_match(pn_xml,"/name/title",pn.name_prefix)
      end
    end
    
    context "PersonLike " do
     should "be able to serialize itslef to hdata xml" do
       p = Patient.find_by_name("Joe Smith")
       xml =  Builder::XmlMarkup.new
       str = xml.person do
         Hdata::Core::Person.to_hdata(p.registration_information,xml)
        end
       doc =   REXML::Document.new(str)
       # we already tested that the individual components serialize correctly 
       # no need t do that here, just see if the elements are in the wrapper node
       assert !REXML::XPath.first(doc, "/person/name").nil?
       assert !REXML::XPath.first(doc, "/person/address").nil?
       assert !REXML::XPath.first(doc, "/person/telecom").nil?
          
     end
   end
    


  private 
  
  def assert_code_system_values(xml, root_path, attributes)
    attributes.each_pair do |attribute,value|
      error assert_xml_match(xml,"#{root_path}/@#{attribute}",value).nil?
      puts error if error
      assert error.nil?
    end
  end

end