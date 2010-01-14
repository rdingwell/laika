require "#{File.dirname(__FILE__)}/../test_helper"
require 'builder'
require 'hdata'


class CoreTest < Test::Unit::TestCase
  

  @@namespaces = {"core"=>Hdata::Core::NAMESPACE}
  context "Address model " do
     should "be able to serialize itself to xml" do 
      addr =  Address.new(:state=>"MA", :city=>"NBPT", 
                            :postal_code=>"01950" , 
                          :iso_country=>IsoCountry.find_by_code("us"), 
                          :street_address_line_one=>"line_one", 
                          :street_address_line_two=>"line_two")
    
     
       doc = wrap_core_xml{|xml| addr.to_hdata(xml,"core:address")}
      

      assert_xml_match(doc,"/root/core:address/core:city",addr.city , @@namespaces)
      assert_xml_match(doc,"/root/core:address/core:zip",addr.postal_code , @@namespaces)
      assert_xml_match(doc,"/root/core:address/core:stateOrProvince",addr.state , @@namespaces)
      assert_xml_match(doc,"/root/core:address/core:streetAddress[1]",addr.street_address_line_one , @@namespaces)
      assert_xml_match(doc,"/root/core:address/core:streetAddress[2]",addr.street_address_line_two , @@namespaces)
      assert_xml_match(doc,"/root/core:address/core:country",addr.iso_country.code , @@namespaces)
    end
  end
  
    context "Race Model" do   
      should "be able to serialize itslef to hdata xml" do
        race = Race.new(:code=>"", :name=>"")

         doc = wrap_core_xml{|xml| race.to_hdata(xml,"core:race")}

        assert_xml_match(doc,"/root/core:race/@code" , race.code , @@namespaces)
        assert_xml_match(doc,"/root/core:race/@displayName" , race.name , @@namespaces)
        assert_xml_match(doc,"/root/core:race/@codeSystem" , "2.16.840.1.113883.6.238" , @@namespaces)
        assert_xml_match(doc,"/root/core:race/@codeSystemName" ,"CDC Race and Ethnicity" , @@namespaces)
        
      end
    
    end
    
    
    context "Marital Status" do
      should "be able to serialize itslef to hdata xml" do
         ms = MaritalStatus.new(:code=>"A", :name=>"Anulled")
         
          doc = wrap_core_xml{|xml| ms.to_hdata(xml,"core:maritalStatus") }
          
          assert_xml_match(doc,"/root/core:maritalStatus/@code" , ms.code , @@namespaces)
          assert_xml_match(doc,"/root/core:maritalStatus/@displayName" , ms.name , @@namespaces)
          assert_xml_match(doc,"/root/core:maritalStatus/@codeSystem" , "2.16.840.1.113883.5.2" , @@namespaces)
          assert_xml_match(doc,"/root/core:maritalStatus/@codeSystemName" ,"HL7 MaritalStatusCode" , @@namespaces)
      end
    end
    
    context "Language" do
      should "be able to serialize itslef to hdata xml" do
        lang = Language.new(:iso_language=> IsoLanguage.new(:code=>"en"),
                            :iso_country=>IsoCountry.new(:code=>"gb"))
       
         doc = wrap_core_xml{|xml| lang.to_hdata(xml,"core:language")}
       

        assert_xml_match(doc,"/root/core:language/@code" , lang.iso_language.code+ "-" + lang.iso_country.code , @@namespaces)
        assert_xml_match(doc,"/root/core:language/@displayName" , nil , @@namespaces)
        assert_xml_match(doc,"/root/core:language/@codeSystem" , "NA" , @@namespaces)
        assert_xml_match(doc,"/root/core:language/@codeSystemName" ,"NA" , @@namespaces)

        
      end
    end
    
    context "Telecom" do
      should "be able to serialize itslef to hdata xml" do
        tel = Telecom.new
        tel.randomize

        doc = wrap_core_xml{|xml| tel.to_hdata(xml,"core:telecom") }
        
       

        if tel.home_phone
          assert_xml_match(doc,"/root/core:telecom[@use='home' and  @value='#{tel.home_phone}']/@type", "phone-landline" , @@namespaces)
        end
        if tel.work_phone
          assert_xml_match(doc.root,"/root/core:telecom[@use='work'  and @value='#{tel.work_phone}']/@type", "phone-landline" , @@namespaces)

        end
        if tel.mobile_phone
          assert_xml_match(doc.root,"/root/core:telecom[@use='other'  and @value='#{tel.mobile_phone}']/@type", "phone-cell" , @@namespaces)

        end
        if tel.vacation_home_phone
          assert_xml_match(doc,"/root/core:telecom[@use='other'  and @value='#{tel.vacation_home_phone}']/@type", "phone-landline" , @@namespaces)
        end
        if tel.email
          assert_xml_match(doc,"/root/core:telecom[@use='other'  and @value='#{tel.email}']/@type", "email" , @@namespaces)
        end
        if tel.url
          assert_xml_match(doc,"/root/core:telecom[@use='other'  and @value='#{tel.url}']/@type", "other" , @@namespaces)
        end
      end
    end
    
    context "Gender" do
      should "be able to serialize itslef to hdata xml" do
       gen = Gender.new(:code=>"M",:name=>"Male")
     
        doc = wrap_core_xml{|xml| gen.to_hdata(xml,"core:gender")}
      
       assert_xml_match(doc,"/root/core:gender/@code" , gen.code , @@namespaces)
       assert_xml_match(doc,"/root/core:gender/@displayName" , gen.name , @@namespaces)
       assert_xml_match(doc,"/root/core:gender/@codeSystem" , "2.16.840.1.113883.5.1" , @@namespaces)
       assert_xml_match(doc,"/root/core:gender/@codeSystemName" ,"HL7 AdministrativeGenderCode" , @@namespaces)      
      end
    end
    
    context "PersonName" do
      should "be able to serialize itslef to hdata xml" do
        pn = PersonName.new(:name_prefix=>"pre", :first_name=>"first",:last_name=>"last",:middle_name=>"middle",:name_suffix=>"suf")
        
        doc = wrap_core_xml{|xml| pn.to_hdata(xml,"core:name") }
       
        
        assert_xml_match(doc,"/root/core:name/core:given[1]",pn.first_name , @@namespaces)
        assert_xml_match(doc,"/root/core:name/core:given[2]",pn.middle_name , @@namespaces)
        assert_xml_match(doc,"/root/core:name/core:lastname",pn.last_name , @@namespaces)
        assert_xml_match(doc,"/root/core:name/core:suffix",pn.name_suffix , @@namespaces)
        assert_xml_match(doc,"/root/core:name/core:title",pn.name_prefix , @@namespaces)
      end
    end
    
    context "PersonLike " do
     should "be able to serialize itslef to hdata xml" do
       p = Patient.find_by_name("Joe Smith")
       
       doc = wrap_core_xml do |xml|
         Hdata::Core::PersonLike.to_hdata(p.registration_information,xml)
        end
       
       # we already tested that the individual components serialize correctly 
       # no need t do that here, just see if the elements are in the wrapper node
       assert !REXML::XPath.first(doc, "/root/core:name", @@namespaces).nil?
       assert !REXML::XPath.first(doc, "/root/core:address").nil?
       assert !REXML::XPath.first(doc, "/root/core:telecom").nil?
          
     end
   end
    


  private 
  
   def wrap_core_xml(&block)
      xml =  Builder::XmlMarkup.new(:indent=>2)
      xml.root("xmlns:core"=>Hdata::Core::NAMESPACE) do
         yield xml if block_given?
      end
      puts xml.target!
      doc = REXML::Document.new(xml.target!)
      doc       
   end

end