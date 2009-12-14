# Hdata
module Hdata
  module Core
    
    module Telecom
      
    end
    
    module Language
      
    end
    
    
    
    module Address
   
      # <xs:complexType name="address">
      #       <xs:sequence>
      #         <xs:element name="streetAddress" minOccurs="0" maxOccurs="unbounded" type="xs:string"/>
      #         <xs:element name="city" type="xs:string"/>
      #         <xs:element minOccurs="0" name="stateOrProvince" type="xs:string"/>
      #         <xs:element name="zip" minOccurs="0" type="xs:string"/>
      #         <xs:element minOccurs="0" name="country" type="xs:string"/>
      #       </xs:sequence>
      #     </xs:complexType>
    def to_hdata( xml)
      #as an address is a complex type it is assumed that the builder will be passed in and the 
      #correct wrapping element will have been created already
      
      xml.streetAddress(addr.street_address_line_one) if addr.street_address_line_one
      xml.streetAddress(addr.street_address_line_two) if addr.street_address_line_two
      xml.city(addr.city) if addr.city
      xml.stateOrProvince(addr.state) if addr.state
      xml.zip(addr.postal_code) if addr.postal_code
      xml.country(addr.iso_country.code) if addr.iso_country
      
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
     
     def to_hdata(xml)
        xml.gender"code" => gender.code,
                  "displayName" => gender.name, 
                  "codeSystemName" => "HL7 AdministrativeGenderCodes",
                  "codeSystem" => "2.16.840.1.113883.5.1") do
          xml.originalText("AdministrativeGender codes are: M (Male), F (Female) or UN (Undifferentiated).")
     end
     
   end

   module Person
    
    def self.to_hdata(person,xml)
      
    end
  end
    
  end
  
end
