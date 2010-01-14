module Hdata
  module Translation
    module InsuranceProvider
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
      #   targetNamespace="http://projecthdata.org/hdata/schemas/2009/06/insurance_provider" 
      #   xmlns:ip="http://projecthdata.org/hdata/schemas/2009/06/insurance_provider"  
      #   xmlns:core="http://projecthdata.org/hdata/schemas/2009/06/core">
      # 
      #   <xs:import namespace="http://projecthdata.org/hdata/schemas/2009/06/core" schemaLocation="core_data_types.xsd"/>
      #   <xs:include schemaLocation="insurance_provider_types.xsd"/>
      #   <xs:element name="insuranceProvider">
      #     <xs:complexType>
      #       <xs:sequence>
      #         <xs:element name="id" type="core:instanceIdentifier"/>
      #         <xs:element name="healthInsuranceType" type="ip:healthInsuranceTypeCode" minOccurs="0"/>
      #         <xs:element name="payer" type="core:actor"/>
      #         <xs:element name="healthPlanCoverageDates" type="core:dateRange"/>
      #         <xs:element name="patient" type="ip:patient"/>
      #         <xs:element name="financialResponsibilityPartyType" type="ip:financialResponsibilityPartyType"/>
      #         <xs:element name="subscriber" type="ip:subscriber"/>
      #         <xs:element name="guarantorInformation" type="ip:guarantorInformation"/>
      #         <xs:element name="healthPlanName" type="xs:string"/>
      #         <xs:element name="informationSource" type="core:informant" minOccurs="0" maxOccurs="unbounded"/>
      #         <xs:element name="narrative" type="xs:string"/>
      #       </xs:sequence>
      #     </xs:complexType>
      #   </xs:element>
      # 
      # </xs:schema>
      
      def to_hdata(xml)
        xml.instruct! :xml, :version => '1.0'
        xml.insuranceProvider(:xmlns => "http://projecthdata.org/hdata/schemas/2009/06/insurance_provider",
        "xmlns:core" => Hdata::Core::NAMESPACE) do       
          xml.id(:root=>group_number) if group_number
          xml.healthInsuranceType("code"=>insurance_type.code, "codeSystem"=>"2.16.840.1.113883.6.255.1336", 
           "codeSystemName" => "X12N-1336", "displayName"=>insurance_type.name)
          if insurance_type && insurance_type.code != "PP"
            xml.payer do
              xml.tag!("core:organization") do
                # xml.pointOfContact do
                #                  Hdata::Core::PersonLike.to_hdata(insurance_provider_guarantor,xml)
                #                end
                xml.tag!("core:name", represented_organization)
              end
              
            end
            
            
          end
          attrs ={}
          attrs[:low] =insurance_provider_patient.start_coverage_date.to_s(:iso8601) if insurance_provider_patient.start_coverage_date
          attrs[:high] =insurance_provider_patient.end_coverage_date.to_s(:iso8601) if insurance_provider_patient.end_coverage_date
          xml.healthPlanCoverageDates(attrs) if !attrs.empty?
          
          xml.patient do
            Hdata::Core::PersonLike.to_hdata(insurance_provider_patient,xml)
            xml.memberId(:root=>insurance_provider_patient.member_id) if insurance_provider_patient.member_id
            xml.patientRelationshipToSubscriber do
              
            end
            
            xml.patientDateOfBirth insurance_provider_patient.date_of_birth if insurance_provider_patient.date_of_birth
          end
          xml.subscriber do
            Hdata::Core::PersonLike.to_hdata(insurance_provider_subscriber,xml)
            xml.subscriberId(:root=>insurance_provider_subscriber.subscriber_id)
            xml.subscriberDateOfBirth(insurance_provider_subscriber.date_of_birth.to_s) if insurance_provider_subscriber.date_of_birth
          end
          if insurance_type && insurance_type.code == "PP"
            if insurance_provider_guarantor && !insurance_provider_guarantor.person_blank?
              xml.guarantorInformation do
                xml.financialResponsibilityParty do
                  xml.tag!("core:person") do
                    Hdata::Core::PersonLike.to_hdata(insurance_provider_guarantor,xml)
                  end
                end             
              end
            end
          end
          xml.healthPlanName health_plan if health_plan
        end
      end
      
    end
  end
end
