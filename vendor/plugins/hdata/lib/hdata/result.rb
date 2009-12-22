module Hdata
  module Translation
    
    module AbstractResult
      
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
          # <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" 
          #   elementFormDefault="qualified" 
          #   targetNamespace="http://projecthdata.org/hdata/schemas/2009/06/result" 
          #   xmlns:result="http://projecthdata.org/hdata/schemas/2009/06/result" 
          #   xmlns:core="http://projecthdata.org/hdata/schemas/2009/06/core">
          # 
          #   <xs:import namespace="http://projecthdata.org/hdata/schemas/2009/06/core" schemaLocation="core_data_types.xsd"/>
          #   <xs:include schemaLocation="result_types.xsd"/>
          # 
          #   <xs:element name="result">
          #     <xs:annotation>
          #       <xs:documentation>
          #         This section is used to describe test results/vital signs.
          # 
          #         Element names map to HITSP Data Element Names in the HITSP C83, with the expcetion informationSource and narrative
          # 
          #         informationSource maps to the HITSP Information Source Content Module Specified in the C83
          # 
          #         narrative element referrs to narrative (human readable) style content. Usually a human readable version of the
          #         encoded content.
          #       </xs:documentation>
          #     </xs:annotation>
          #     <xs:complexType>
          #       <xs:sequence>
          #         <xs:element name="resultId" type="core:instanceIdentifier"/>
          #         <xs:element name="resultDateTime" type="core:dateRange"/>
          #         <xs:element name="resultType" type="result:resultType"/>
          #         <xs:element name="resultStatus" type="core:statusCode"/>
          #         <xs:element name="resultValue" type="xs:anyType"/><!-- CCD CONF-417: SHALL be expressed using UCUM expression when physical quantity -->
          #         <xs:element name="resultInterpretation" type="core:codedValue" minOccurs="0"/>
          #         <xs:element name="resultReferenceRange" type="result:resultReferenceRange" minOccurs="0" maxOccurs="unbounded"/>
          #         <xs:element name="informationSource" type="core:informant" minOccurs="0" maxOccurs="unbounded"/>
          #         <xs:element name="narrative" type="xs:string"/>
          #       </xs:sequence>
          #     </xs:complexType>
          #   </xs:element>
          # 
          # </xs:schema>

           
           
         def to_hdata(xml)
           
            xml.result(:xmlns => "http://projecthdata.org/hdata/schemas/2009/06/results",
                           "xmlns:core" => Hdata::Core::NAMESPACE) do  
              xml.resultId(result_id)
              if result_date.present?
                xml.resultDateTime(:low=>result_date.to_formatted_s(:brief))
             end
              if result_type_code.present?
              xml.resultType("code" => result_type_code.code, 
                        "codeSystem" => "2.16.840.1.113883.6.96", 
                        "displayName" => result_type_code.name)
              end
              
              if status_code
                xml.resultStatus(:code=>status_code.code,:codeSystem=>status_code.code_system, :displayName=>status_code.name )
              end
              
              xml.resultValue do
                 if self.result_code
                   xml.code("xsi:type"=>"core:codedValue", "code" => result_code, "displayName" => result_code_display_name,
                            "codeSystem" => code_system.try(:code),
                            "codeSystemName" => code_system.try(:name))
                 end
                xml.unit(value_unit)
                xml.value(value_scalar)
              end


            end
      end
      
    end
    
    module Result
  
      def to_hdata(xml)
         xml.instruct! :xml, :version => '1.0' 
         super(xml)
      end
    end
    
    
    # <?xml version="1.0" encoding="UTF-8"?>
    # <!-- 
    #     Copyright 2009 The MITRE Corporation 
    # 
    #     Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. 
    #     You may obtain a copy of the License at 
    # 
    #     http://www.apache.org/licenses/LICENSE-2.0 
    # 
    #     Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an 
    #     "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific 
    #     language governing permissions and limitations under the License. 
    # -->
    # <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"
    #     targetNamespace="http://projecthdata.org/hdata/schemas/2009/06/vital_signs"
    #     xmlns:core="http://projecthdata.org/hdata/schemas/2009/06/core"
    #     xmlns:vs="http://projecthdata.org/hdata/schemas/2009/06/vital_signs"
    #     xmlns:results="http://projecthdata.org/hdata/schemas/2009/06/result">
    # 
    #     <xs:import namespace="http://projecthdata.org/hdata/schemas/2009/06/core" schemaLocation="core_data_types.xsd"/>
    #     <xs:import namespace="http://projecthdata.org/hdata/schemas/2009/06/result" schemaLocation="result.xsd"/>
    # 
    #     <xs:element name="vitalSigns">
    #     <xs:complexType>
    #         <xs:annotation>
    #             <xs:documentation>
    #                 This represents the overall structure of the C32 Vital Signs Module. The Vital
    #                 Signs Module current and relevant historical vital signs for the patient. Vital
    #                 Signs are a subset of Results, but are reported in this section to follow clinical
    #                 conventions. As such, this element follows the same structure (with a few additional
    #                 constraints) as the Results module.
    #                 This data should be included in a component tag with an xsi:type="VitalSigns" attribute.
    #             </xs:documentation>
    #         </xs:annotation>
    #         <xs:sequence>
    #             <xs:element name="effectiveTime" type="xs:dateTime"/>
    #             <xs:element name="text" type="xs:string"/>
    #             <xs:element ref="results:result" maxOccurs="unbounded"/>
    #         </xs:sequence>
    #     </xs:complexType>
    #     </xs:element>
    # 
    # 
    # </xs:schema>
    
    module VitalSign
      
      def to_hdata(xml)
        xml.instruct! :xml, :version => '1.0' 
          xml.vitalSign(:xmlns => "http://projecthdata.org/hdata/schemas/2009/06/vital_signs",
                         "xmlns:core" => Hdata::Core::NAMESPACE) do    
          if result_date.present?
             xml.effectiveTime(:low=>result_date.to_formatted_s(:brief))
          end    
          xml.text  result_type_code.name               
          super(xml)  
        end
      end  
      
    end
    
    
    
  end
end
