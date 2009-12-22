module Hdata
  module Translation
    module AdvanceDirective
      
      
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
      #   targetNamespace="http://projecthdata.org/hdata/schemas/2009/06/advance_directive"
      #   xmlns:ad="http://projecthdata.org/hdata/schemas/2009/06/advance_directive"
      #   xmlns:core="http://projecthdata.org/hdata/schemas/2009/06/core">
      # 
      #   <xs:import namespace="http://projecthdata.org/hdata/schemas/2009/06/core"
      #     schemaLocation="core_data_types.xsd"/>
      #   <xs:include schemaLocation="advance_directive_types.xsd"/>
      # 
      #   <xs:element name="advanceDirective">
      #     <xs:annotation>
      #       <xs:documentation> This section contains information regarding any advance directive
      #         pertaining to a patient and a reference to the most up to date supporting documents for the
      #         directives. This is used to describe such information as a patients resusitation status and
      #         the like. The type element is a codedValue object that is used to describe what kind of
      #         advance directive this is. This specification does not currently state a required code
      #         system such as SNOMED CT that should be used, this may change is future versions of the
      #         schema. The use of the codedValues attributes are optional but a system must at the very
      #         least include a free text description of the directive as the value of the type element. The
      #         date element denotes the date the directive was last updated. The optional custodian element
      #         describes the person who currently is responsible for maintaing the advance directive. As
      #         with most other hData sections there is a informationSource (where this data originated) and
      #         a free text narrative section defined for this element. The informationSource is optional. 
      #       </xs:documentation>
      #     </xs:annotation>
      #     <xs:complexType>
      #       <xs:annotation>
      #         <xs:documentation> An Advance Directive Event entry. </xs:documentation>
      #       </xs:annotation>
      #       <xs:sequence>
      #         <xs:element name="type" type="ad:advanceDirectiveType"/>
      #         <xs:element name="freeTextType" type="xs:string" minOccurs="1"/>
      #         <xs:element name="effectiveDate" type="core:dateRange" minOccurs="1"/>
      #         <xs:element name="custodianOfTheDocument" type="core:informant" minOccurs="1" maxOccurs="unbounded"/>
      #         <xs:element name="status" type="ad:statusObservation"/>
      #         <xs:element name="informationSource" type="core:informant" minOccurs="0" maxOccurs="unbounded"/>
      #         <xs:element name="narrative" type="xs:string"/>
      #       </xs:sequence>
      #     </xs:complexType>
      #   </xs:element>
      # 
      # </xs:schema>
      # 
      
      def to_hdata(xml)
        xml.instruct! :xml, :version => '1.0'
          xml.advanceDirective(:xmlns => "http://projecthdata.org/hdata/schemas/2009/06/advanceDirective",
                      "xmlns:core" => Hdata::Core::NAMESPACE) do
            xml.type("code" => advance_directive_type.code, 
                        "displayName" => advance_directive_type.name, 
                        "codeSystem" => "2.16.840.1.113883.6.96",
                        "codeSystemName" => "SNOMED CT")
                        
                        
            xml.freeTextType(free_text)
            
            if start_effective_time.present? || end_effective_time.present?
              attrs = {}
              attrs[:low] = start_event.to_s if start_event.present?
              attrs[:high] = end_event.to_s if end_event.present?          
              xml.effectiveDate(attrs)
            end

            xml.custodianOfTheDocument do
              xml.contact do
                Hdata::Core::PersonLike.to_hdata(self,xml)
              end
            end
            
            xml.status("code" => advance_directive_status_code.code, 
                       "codeSystem" => "2.16.840.1.113883.6.96", 
                       "displayName" => advance_directive_status_code.name)

                        
                        
        end
      end
      
      
   
         
    end
  end
end

      