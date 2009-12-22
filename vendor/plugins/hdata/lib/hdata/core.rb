# Hdata
module Hdata
  module Core
    NAMESPACE = "http://projecthdata.org/hdata/schemas/2009/06/core"
    
    # <xs:complexType name="telecom">
    #     <xs:attribute name="value" use="required"/>
    #     <xs:attribute name="type" use="required">
    #       <xs:simpleType>
    #          <xs:restriction base="xs:string">
    #            <xs:enumeration value="phone-landline"/>
    #            <xs:enumeration value="phone-cell"/>
    #            <xs:enumeration value="phone-fax"/>
    #            <xs:enumeration value="phone-pager"/>
    #            <xs:enumeration value="phone-sms"/>
    #            <xs:enumeration value="email"/>
    #            <xs:enumeration value="im"/>
    #            <xs:enumeration value="other"/>
    #          </xs:restriction> 
    #       </xs:simpleType>
    #     </xs:attribute>
    #     <xs:attribute name="use" use="required">
    #       <xs:simpleType>
    #         <xs:restriction base="xs:string">
    #           <xs:enumeration value="home"/>
    #           <xs:enumeration value="work"/>
    #           <xs:enumeration value="other"/>
    #         </xs:restriction>
    #       </xs:simpleType>
    #     </xs:attribute>
    #     <xs:attribute default="false" name="prefered" type="xs:boolean"/>
    #   </xs:complexType>
    
    module Telecom
     
      def to_hdata(xml,tag="telecom")
        if home_phone && home_phone.size > 0
          xml.tag!(tag, "type"=>"phone-landline","use" => "home", "value" =>  home_phone)
        end
        if work_phone && work_phone.size > 0
         xml.tag!(tag, "type"=>"phone-landline","use" => "work", "value" =>  work_phone)
        end
        if mobile_phone && mobile_phone.size > 0
          xml.tag!(tag, "type"=>"phone-cell","use" => "other", "value" => mobile_phone)
        end
        if vacation_home_phone && vacation_home_phone.size > 0
          xml.tag!(tag, "type"=>"phone-landline","use" => "other", "value" =>  vacation_home_phone)
        end
        if email && email.size > 0
          xml.tag!(tag, "type"=>"email","use"=>"other" ,"value" =>  email)
        end
        if url && url.size > 0
          xml.tag!(tag, "type"=>"other","use"=>"other","value" => url)
        end
      end
    end
    
    
    # <xs:complexType name="language">
    #   <xs:complexContent>
    #     <xs:restriction base="core:codedValue">
    #       <xs:attribute name="code" type="xs:string" use="required"/>
    #       <xs:attribute name="codeSystem" type="xs:string" use="required"/>
    #       <xs:attribute name="codeSystemName" type="xs:string"/>
    #       <xs:attribute name="version" use="optional"/>
    #       <xs:attribute name="displayName" type="xs:string" use="optional"/>
    #     </xs:restriction>
    #   </xs:complexContent>
    # </xs:complexType>
    module Language
         
      def to_hdata(xml, tag="language")
        xml.tag!(tag, "code" => iso_language.code + "-" + iso_country.code,"codeSystem"=>"NA", "codeSystemName"=>"NA")       
      end
      
    end
    
    # <xs:complexType name="maritalStatus">
    #       <xs:annotation>
    #         <xs:documentation> Marital status shall be represented by HL7 Marital status vocabulary V15929
    #           The marital status of the patient at date of admission, outpatient service or start of care.
    #           Values such as: single married, Life Partner, Legally Separated, Divorced, Widowed, Unknown.
    #           Form Locator 16 in the NUBC document. This is to be used only in situations where
    #           regulations require the use of NUBC marital status codes. A Annulled Marriage contract has
    #           been declared null and to not have existed D Divorced Marriage contract has been declared
    #           dissolved and inactive I Interlocutory Subject to an Interlocutory Decree. L Legally
    #           Separated M Married A current marriage contract is active P Polygamous More than 1 current
    #           spouse S Never Married No marriage contract has ever been entered T Domestic partner Person
    #           declares that a domestic partner relationship exists. W Widowed The spouse has died
    #         </xs:documentation>
    #       </xs:annotation>
    #       <xs:complexContent>
    #         <xs:restriction base="core:codedValue">
    #           <xs:attribute name="code" use="required">
    #             <xs:simpleType>
    #               <xs:restriction base="xs:string">
    #                 <xs:enumeration value="A"/>
    #                 <xs:enumeration value="D"/>
    #                 <xs:enumeration value="I"/>
    #                 <xs:enumeration value="L"/>
    #                 <xs:enumeration value="M"/>
    #                 <xs:enumeration value="P"/>
    #                 <xs:enumeration value="S"/>
    #                 <xs:enumeration value="T"/>
    #                 <xs:enumeration value="W"/>
    #               </xs:restriction>
    #             </xs:simpleType>
    #           </xs:attribute>
    #           <xs:attribute name="displayName" use="optional">
    #             <xs:simpleType>
    #               <xs:restriction base="xs:string">
    #                 <xs:enumeration value="Annulled"/>
    #                 <xs:enumeration value="Divorced"/>
    #                 <xs:enumeration value="Interlocutory"/>
    #                 <xs:enumeration value="Legally Separated"/>
    #                 <xs:enumeration value="Married"/>
    #                 <xs:enumeration value="Polygamous"/>
    #                 <xs:enumeration value="Never Married"/>
    #                 <xs:enumeration value="Domestic Partner"/>
    #                 <xs:enumeration value="Widowed"/>
    #               </xs:restriction>
    #             </xs:simpleType>
    #           </xs:attribute>
    #           <xs:attribute name="codeSystemName" type="xs:string" fixed="HL7 MaritalStatusCode"/>
    #           <xs:attribute name="codeSystem" use="required" type="xs:string" fixed="2.16.840.1.113883.5.2"/>
    #         </xs:restriction>
    #       </xs:complexContent>
    #     </xs:complexType>
    #   
    module MaritalStatus
      def to_hdata(xml,tag="maritalStatus")
             xml.tag!(tag,"code" => code, 
                                   "displayName" => name, 
                                   "codeSystemName" => "HL7 MaritalStatusCode", 
                                   "codeSystem" => "2.16.840.1.113883.5.2")
      end
                                 
    end
    
     # <xs:complexType name="address">
      #       <xs:sequence>
      #         <xs:element name="streetAddress" minOccurs="0" maxOccurs="unbounded" type="xs:string"/>
      #         <xs:element name="city" type="xs:string"/>
      #         <xs:element minOccurs="0" name="stateOrProvince" type="xs:string"/>
      #         <xs:element name="zip" minOccurs="0" type="xs:string"/>
      #         <xs:element minOccurs="0" name="country" type="xs:string"/>
      #       </xs:sequence>
      #     </xs:complexType>
          
    module Address
     
     def to_hdata( xml, tag="address")
           #as an address is a complex type it is assumed that the builder will be passed in and the 
           #correct wrapping element will have been created already
           xml.tag!(tag) do
             xml.tag!("core:streetAddress", street_address_line_one) if street_address_line_one.present?
             xml.tag!("core:streetAddress", street_address_line_two) if street_address_line_two.present?
             xml.tag!("core:city",city) if city.present?
             xml.tag!("core:stateOrProvince", state) if state.present?
             xml.tag!("core:zip", postal_code) if postal_code.present?
             xml.tag!("core:country", iso_country.code) if iso_country.present?
           end
       end
       
       
       def self.validate_hdata(xml)
         
       end
       
    end
    

  
   
   # <xs:complexType name="gender">
   #      <xs:annotation>
   #        <xs:documentation> HL7 AdministrativeGender codes M - Male F - Female UN- Undifferentiated
   #        </xs:documentation>
   #      </xs:annotation>
   #      <xs:complexContent>
   #        <xs:restriction base="core:codedValue">
   #          <xs:attribute name="code" use="required">
   #            <xs:simpleType>
   #              <xs:restriction base="xs:string">
   #                <xs:enumeration value="M"/>
   #                <xs:enumeration value="F"/>
   #                <xs:enumeration value="UN"/>
   #              </xs:restriction>
   #            </xs:simpleType>
   #          </xs:attribute>
   #          <xs:attribute name="codeSystemName" type="xs:string" fixed="HL7 AdministrativeGenderCode"/>
   #          <xs:attribute name="codeSystem" type="xs:string" use="required"
   #            fixed="2.16.840.1.113883.5.1"/>
   #          <xs:attribute name="version"/>
   #          <xs:attribute name="displayName">
   #            <xs:simpleType>
   #              <xs:restriction base="xs:string">
   #                <xs:enumeration value="Male"/>
   #                <xs:enumeration value="Female"/>
   #                <xs:enumeration value="Undifferentiated"/>
   #              </xs:restriction>
   #            </xs:simpleType>
   #          </xs:attribute>
   #        </xs:restriction>
   #      </xs:complexContent>
   #    </xs:complexType>
   module Gender
     
     def to_hdata(xml,tag="gender")
        xml.tag!(tag,"code" => code,
                  "displayName" => name, 
                  "codeSystemName" => "HL7 AdministrativeGenderCode",
                  "codeSystem" => "2.16.840.1.113883.5.1")
     end
     
   end
   
   # <xs:complexType name="race">
   #       <xs:complexContent>
   #         <xs:restriction base="core:codedValue">
   #           <xs:attribute name="code" use="required">
   #             <xs:simpleType>
   #               <xs:restriction base="xs:string">
   #                 <xs:enumeration value="1004-1"/>
   #                 <xs:enumeration value="2028-9"/>
   #                 <xs:enumeration value="2058-6"/>
   #                 <xs:enumeration value="2076-8"/>
   #                 <xs:enumeration value="2106-3"/>
   #                 <xs:enumeration value="2131-1"/>
   #               </xs:restriction>
   #             </xs:simpleType>
   #           </xs:attribute>
   #           <xs:attribute name="displayName" use="optional">
   #             <xs:annotation>
   #               <xs:documentation source="http://www.whitehouse.gov/omb/fedreg/ombdir15.html"> OFFICE OF
   #                 MANAGEMENT AND BUDGET Revisions to the Standards for the Classification of Federal
   #                 Data on Race and Ethnicity </xs:documentation>
   #             </xs:annotation>
   #             <xs:simpleType>
   #               <xs:restriction base="xs:string">
   #                 <xs:enumeration value="American Indian or Alaska Native"/>
   #                 <xs:enumeration value="Asian"/>
   #                 <xs:enumeration value="Black or African American"/>
   #                 <xs:enumeration value="Native Hawaiian or Other Pacific Islander"/>
   #                 <xs:enumeration value="White"/>
   #                 <xs:enumeration value="Other Race"/>
   #               </xs:restriction>
   #             </xs:simpleType>
   #           </xs:attribute>
   #           <xs:attribute name="codeSystemName" type="xs:string" fixed="CDC Race and Ethnicity"/>
   #           <xs:attribute name="codeSystem" use="required" type="xs:string"
   #             fixed="2.16.840.1.113883.6.238"/>
   #         </xs:restriction>
   #       </xs:complexContent>
   #     </xs:complexType>
     module Race
      HDATA_RACE_CODES = {"1004-1"=> "American Indian or Alaska Native" , 
                          "2028-9"=>"Asian",
                          "2058-6"=>"Black or African American",
                          "2076-8"=>"Native Hawaiian or Other Pacific Islander",
                          "2106-3"=>"White",
                          "2132-1"=>"Other Race"} 
                          
     def to_hdata(xml,tag="race")
     xml.tag!(tag, "code" => code, 
                  "displayName" => name, 
                  "codeSystemName" => "CDC Race and Ethnicity", 
                  "codeSystem" => "2.16.840.1.113883.6.238")
     end
     end

   # <xs:complexType name="name">
   #   <xs:sequence>
   #     <xs:element minOccurs="0" name="title" type="xs:string"/>
   #     <xs:element name="given" type="xs:string" maxOccurs="unbounded"/>
   #     <xs:element minOccurs="0" name="lastname" type="xs:string"/>
   #     <xs:element minOccurs="0" name="suffix" type="xs:string"/>
   #   </xs:sequence>
   # </xs:complexType>
   module PersonName
     def to_hdata(xml,tag="name")
       xml.tag!(tag) do
         if name_prefix.present?
           xml.tag!("core:title", name_prefix)
         end
         if first_name.present?
           xml.tag!("core:given",first_name)
         end
         if middle_name.present?
           xml.tag!("core:given",middle_name)
         end
         if last_name.present?
           xml.tag!("core:lastname",last_name)
         end
         if name_suffix.present?
           xml.tag!("core:suffix",name_suffix)
         end
       end
     end
   end
   
   module Person   
    def self.to_hdata(person,xml)
      person.person_name.try(:to_hdata, xml,"core:name")
      person.address.try(:to_hdata, xml,"core:address")
      person.telecom.try(:to_hdata, xml,"core:telecom")
    end
  end
end

end
