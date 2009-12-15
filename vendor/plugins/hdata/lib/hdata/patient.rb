module Hdata
  module Translation
    module Patient
    
    require 'builder'
    # <?xml version="1.0" encoding="UTF-8"?>
    # <!-- 
    #   Copyright 2009 The MITRE Corporation 
    # 
    #   Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. 
    #   You may obtain a copy of the License at 
    # 
    #   http://www.apache.org/licenses/LICENSE-2.0 
    # 
    #   Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an 
    #   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific 
    #   language governing permissions and limitations under the License. 
    # -->
    # <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"
    #   targetNamespace="http://projecthdata.org/hdata/schemas/2009/06/patient_information"
    #   xmlns:p="http://projecthdata.org/hdata/schemas/2009/06/patient_information"
    #   xmlns:core="http://projecthdata.org/hdata/schemas/2009/06/core">
    # 
    #   <xs:import namespace="http://projecthdata.org/hdata/schemas/2009/06/core"
    #     schemaLocation="core_data_types.xsd"/>
    # 
    #   <xs:element name="patient">
    #   <xs:complexType>
    #       <xs:complexContent>
    #         <xs:extension base="core:person">
    #           <xs:sequence>
    #             <xs:element name="id" type="xs:string"/>
    #             <xs:element name="gender" type="core:gender" minOccurs="0"/>
    #             <xs:element name="language" minOccurs="0" maxOccurs="unbounded" type="core:language"/>
    #             <xs:element name="birthtime" type="xs:dateTime" minOccurs="0"/>
    #             <xs:element name="maritialStatus" type="core:maritalStatus" minOccurs="0"/>
    #             <xs:element name="race" type="core:race" maxOccurs="unbounded" minOccurs="0"/>
    #             <xs:element name="guardian" minOccurs="0" type="core:person"/>
    #             <xs:element name="birthPlace" type="core:address" minOccurs="0" maxOccurs="1"/>
    #           </xs:sequence>
    #         </xs:extension>
    #       </xs:complexContent>
    #     </xs:complexType>
    #   </xs:element>
    # 
    # </xs:schema>
    def to_hdata(xml)
      xml.instruct! :xml, :version => '1.0'
      xml.patient(:xmlns => "http://projecthdata.org/hdata/schemas/2009/06/patient_information",
                  "xmlns:core" => Hdata::Core::NAMESPACE) do
        # the patient model in laika does not have a first and last name field for a patient, just a name field
       
        if registration_information.present?
          Hdata::Core::Person.to_hdata(self.registration_information,xml)
        else       
          xml.name do
            xml.given(name)
          end
        end
        
        xml.id(id)
        
        registration_information.gender.try(:to_hdata, xml) if registration_information.present?
        languages.each do |lang|
          lang.to_hdata(xml)
        end
        if registration_information.present?
          xml.birthtime(registration_information.date_of_birth.to_utc) 
          registration_information.marital_status.try(:to_hdata,xml) 
          registration_information.race.try(:to_hdata,xml) 
        end
         # do the gaurdian stuff here non gaurdian is placed elsewhere
          if support && support.contact_type.try(:code) == "GUARD"
             xml.guardian do
               Hdata::Core::Person.to_hdata(support,xml)
             end
          end
        
        # xml.birthPlace laika does not have birthPlace so it's a no go
      end
    
    end
    
  end
end
  
end