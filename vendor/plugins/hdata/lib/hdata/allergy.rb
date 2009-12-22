module Hdata
  module Translation
    module Allergy
      # 
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
      #   targetNamespace="http://projecthdata.org/hdata/schemas/2009/06/allergy"
      #   xmlns:allergy="http://projecthdata.org/hdata/schemas/2009/06/allergy"
      #   xmlns:core="http://projecthdata.org/hdata/schemas/2009/06/core">
      # 
      #   <xs:import namespace="http://projecthdata.org/hdata/schemas/2009/06/core"
      #     schemaLocation="core_data_types.xsd"/>
      #   <xs:include schemaLocation="allergy_types.xsd"/>
      # 
      # 
      #   <xs:element name="allergy">
      #     <xs:annotation>
      #       <xs:documentation>
      #       This section is used to describe a patients allergies and intolerances to various substances.  The section defines a number of 
      #       codedValue sections which are constrained to particular coding system (SNOMED CT) which are described below.
      # 
      #       The adverseEventDate element is used to state the date of the last reaction to the allergy or intolerance.
      # 
      #       The product element is a coded value used to describe the substance the patient has the allergy or intolerance too.  There currently is 
      #       not a constraint defined on the code system or code values which can be used to coded the product. At the very least a free text description
      #       the substance must be supplied as the value of the product element with implementers free to choose the coding system of their choice.
      # 
      #       Element names map to HITSP Data Element Names in the HITSP C83, with the expcetion informationSource and narrative
      # 
      #       informationSource maps to the HITSP Information Source Content Module Specified in the C83
      # 
      #       narrative element referrs to narrative (human readable) style content. Usually a human readable version of the
      #       encoded content.
      #       </xs:documentation>
      #     </xs:annotation>
      #     <xs:complexType>
      #       <xs:sequence>
      #         <xs:element name="adverseEventDate" type="core:dateRange" minOccurs="0"/>
      #         <xs:element name="adverseEventType" type="allergy:adverseEventType" minOccurs="0"/>
      #         <xs:element name="product" type="allergy:product"/>
      #         <xs:element name="reaction" type="allergy:reaction"/>
      #         <xs:element name="severity" type="allergy:severity"/>
      #         <xs:element name="alertStatus" type="allergy:alertStatus"/>
      #         <xs:element name="informationSource" type="core:informant" minOccurs="0" maxOccurs="unbounded"/>
      #         <xs:element name="narrative" type="xs:string"/>
      #       </xs:sequence>
      #     </xs:complexType>
      #   </xs:element>
      # 
      # </xs:schema>
      
      def to_hdata(xml) 
          xml.instruct! :xml, :version => '1.0'
            xml.allergy(:xmlns => "http://projecthdata.org/hdata/schemas/2009/06/allergy",
                        "xmlns:core" => Hdata::Core::NAMESPACE) do
            if start_event.present? || end_event.present?
              attrs = {}
              attrs[:low] = start_event.to_s if start_event.present?
              attrs[:high] = end_event.to_s if end_event.present?          
              xml.adverseEventDate(attrs)
            end
            
            if adverse_event_type.present? 
                 xml.adverseEventType("code" => adverse_event_type.code, 
                         "displayName" => adverse_event_type.name, 
                         "codeSystem" => "2.16.840.1.113883.6.96", 
                         "codeSystemName" => "SNOMED CT")
            end
            
             xml.product("code" => product_code, 
                      "displayName" => free_text_product, 
                      "codeSystem" => code_system.code,
                      "codeSystemName" => code_system.name)
          
            
             if severity_term.present?
               xml.severity("code" => severity_term.code,
                            "displayName" => severity_term.name,
                                       "codeSystem" => "2.16.840.1.113883.6.96", 
                                       "codeSystemName" => "SNOMED CT")
             end                         
            
             if allergy_status_code
               xml.alertStatus("code" => allergy_status_code.code,
               "displayName" => allergy_status_code.name,
               "codeSystem" => "2.16.840.1.113883.6.96", 
               "codeSystemName" => "SNOMED CT")
             end          
        end
      end  
    end
  end
end