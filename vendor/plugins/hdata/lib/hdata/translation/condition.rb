module Hdata
  module Translation
    module Condition
      
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
          #   targetNamespace="http://projecthdata.org/hdata/schemas/2009/06/condition"
          #   xmlns:core="http://projecthdata.org/hdata/schemas/2009/06/core"
          #   xmlns:condition="http://projecthdata.org/hdata/schemas/2009/06/condition">
          # 
          #   <xs:import namespace="http://projecthdata.org/hdata/schemas/2009/06/core"
          #     schemaLocation="core_data_types.xsd"/>
          #   <xs:include schemaLocation="condition_types.xsd"/>
          # 
          #   <xs:element name="condition">
          #     <xs:annotation>
          #       <xs:documentation>
          #         This section is used to describe a patients problems/conditions. The types of conditions described have been constrained to the SNOMED CT 
          #         Problem Type code set.
          # 
          #         The problemDate element is used to define the time during which the condition was last observed/active. 
          # 
          #         The problemType element is used to describe the type of problem/condition.
          # 
          #         An unbounded number of treating providers for the particular condition can be supplied.
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
          #         <xs:element name="problemDate" type="core:dateRange"/>
          #         <xs:element name="problemType" type="condition:problemType"/>
          #         <xs:element name="problemName" type="xs:string" minOccurs="0"/>
          #         <xs:element name="problemCode" type="condition:problemCode"/>
          #         <xs:element minOccurs="0" maxOccurs="unbounded" name="treatingProvider">
          #           <xs:complexType>
          #             <xs:annotation>
          #               <xs:documentation>
          #                 Describes a person/organization that has provided treatment for the given condition. 
          # 
          #                 The dateRange element describes the last range that the actor provided treatment for the 
          #                 condition.
          # 
          #                 The provider is represented by the core:actor substitution group which equates to either a 
          #                 person element or and organization element being present.
          # 
          #               </xs:documentation>
          #             </xs:annotation>
          #             <xs:sequence>
          #               <xs:element name="effectiveDate" type="core:dateRange"/>
          #               <xs:element name="actor" type="core:actor"/>
          #             </xs:sequence>
          #           </xs:complexType>
          #         </xs:element>
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
          xml.condition(:xmlns => "http://projecthdata.org/hdata/schemas/2009/06/condition",
                "xmlns:core" => Hdata::Core::NAMESPACE) do

           
              attrs = {}
              attrs[:low] = start_event.to_s(:iso8601) if start_event.present?
              attrs[:high] = end_event.to_s(:iso8601)  if end_event.present?          
              xml.problemDate(attrs) if !attrs.empty?
           

            if problem_type
               xml.problemType("code" => problem_type.code, 
                        "displayName" => problem_type.name, 
                        "codeSystem" => "2.16.840.1.113883.6.96", 
                        "codeSystemName" => "SNOMED CT")
             end

             unless problem_name.blank?
                snowmed_problem = SnowmedProblem.find(:first, :conditions => {:name => problem_name})
                if snowmed_problem
                  xml.problemName(problem_name)
                  xml.problemCode(
                           "code" => snowmed_problem.code, 
                           "displayName" => problem_name,
                           "codeSystem" => "2.16.840.1.113883.6.96",
                           "codeSystemName" => 'SNOMED CT')
                end
              end  
              xml.narrative()           
        end       
      end
      
      def to_atom(xml)
         xml.entry do
         	xml.title "Problem - #{problem_name}"
        			xml.link(:href=>"/hdata/#{patient.id}/conditions/#{self.id}")
        		xml.id(self.id)
         	xml.summary(problem_name)
        	end
      end
      
    end
  end
end
