module Hdata
  module Translation
    module Medication
      
      
      
      # <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"
      #     targetNamespace="http://projecthdata.org/hdata/schemas/2009/06/medication"
      #     xmlns:core="http://projecthdata.org/hdata/schemas/2009/06/core"
      #     xmlns:meds="http://projecthdata.org/hdata/schemas/2009/06/medication"
      #     xmlns:medst="http://projecthdata.org/hdata/schemas/2009/06/medication_types">
      # 
      #     <xs:import namespace="http://projecthdata.org/hdata/schemas/2009/06/core"
      #         schemaLocation="core_data_types.xsd"/>
      #     <xs:import namespace="http://projecthdata.org/hdata/schemas/2009/06/medication_types"
      #         schemaLocation="medication_types.xsd"/>
      # 
      #     <xs:element name="medication">
      #         <xs:complexType>
      #             <xs:sequence>
      #                 <xs:element name="freeTextSig" type="xs:string" minOccurs="0"/>
      #                 <xs:element name="effectiveTime" type="xs:dateTime" minOccurs="1" maxOccurs="2">
      #                     <xs:annotation>
      #                         <xs:documentation>
      #                         Used to indicate actual or intended start and stop date of a medication,
      #                         and frequency of administration.
      #                     </xs:documentation>
      #                     </xs:annotation>
      #                 </xs:element>
      #                 <xs:element name="route" type="medst:routeOrProductForm" minOccurs="0"/>
      #                 <xs:element name="dose" type="medst:dose" minOccurs="0"/>
      #                 <xs:element name="site" type="core:codedValue" minOccurs="0"/>
      #                 <xs:element name="doseRestriction" type="medst:doseRestriction" minOccurs="0"/>
      #                 <xs:element name="productForm" type="medst:routeOrProductForm" minOccurs="0"/>
      #                 <xs:element name="deliveryMethod" type="core:codedValue" minOccurs="0"/>
      #                 <xs:element name="medicationInformation" type="medst:medicationInformation"/>
      #                 <xs:element name="medicationType" type="medst:medicationType" minOccurs="0"/>
      #                 <xs:element name="statusOfMedication" type="medst:statusOfMedication" minOccurs="0"/>
      #                 <xs:element name="patientInstructions" type="xs:string" minOccurs="0"/>
      #                 <xs:element name="orderInformation" type="medst:orderInformation" minOccurs="0"/>
      #                 <xs:element name="informationSource" type="core:informant" minOccurs="0"
      #                     maxOccurs="unbounded"/>
      #                 <xs:element name="narrative" type="xs:string"/>
      #             </xs:sequence>
      #         </xs:complexType>
      #     </xs:element>
      # 
      # </xs:schema>
      # 
      
      # def to_hdata(xml)
      #       
      #        xml.instruct! :xml, :version => '1.0'
      #         xml.patient(:xmlns => "http://projecthdata.org/hdata/schemas/2009/06/medication",
      #                     "xmlns:core" => Hdata::Core::NAMESPACE) do
      #                       
      #           xml.medication do
      #             xml.freeTextSig()
      #             
      #              
      #             if start_event.present?
      #               xml.effectiveTime( start_event.to_s(:brief))
      #             end
      #             if end_event.present?
      #               xml.effectiveTime( end_event.to_s(:brief))
      #             end
      #               
      #             xml.route
      #             xml.dose
      #             xml.site
      #             xml.doseRestriction
      #             xml.productForm
      #             xml.deliveryMethod
      #             xml.medicationInformation do 
      #               xml.manufacturedMaterial do
      #                 
      #               end
      #               
      #             end
      #             xml.statusOfMedication
      #             xml.patientInstructions
      #             xml.orderInformation
      #             xml.informationSource
      #             xml.narrative
      #           end
      #                         
      #        end
      #                     
      #     end
      #     
      #     
      #     def to_c32(xml)
      #       xml.entry {
      #         xml.substanceAdministration("classCode" => "SBADM", "moodCode" => "EVN") {
      #           xml.templateId("root" => "2.16.840.1.113883.10.20.1.24", "assigningAuthorityName" => "CCD")
      #           xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.8", "assigningAuthorityName" => "HITSP/C32")
      #           xml.id
      #           xml.consumable {        
      #             xml.manufacturedProduct("classCode" => "MANU") {
      #               xml.templateId("root" => "2.16.840.1.113883.10.20.1.53", "assigningAuthorityName" => "CCD") 
      #               xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.9", "assigningAuthorityName" => "HITSP/C32") 
      #               xml.manufacturedMaterial("classCode" => "MMAT", "determinerCode" => "KIND") {
      # 
      #                if(product_code && !product_code.blank? && code_system && !code_system.blank?)
      #                 xml.code("code" => product_code, 
      #                          "displayName" => product_coded_display_name, 
      #                          "codeSystem" => code_system.code, 
      #                          "codeSystemName" => code_system.name){
      #                              xml.originalText(product_coded_display_name)
      #                          } 
      #                  end         
      #                 if free_text_brand_name 
      #                   xml.name free_text_brand_name
      #                 end
      #               }
      #             }
      #           }
      # 
      #           if medication_type
      #             xml.entryRelationship("typeCode" => "SUBJ") {
      #               xml.observation("classCode" => "OBS", "moodCode" => "EVN") {                           
      #                 xml.templateId("root" => "2.16.840.1.113883.3.88.11.32.10") 
      #                 xml.code("code" => medication_type.code, 
      #                          "displayName" => medication_type.name, 
      #                          "codeSystem" => "2.16.840.1.113883.6.96", 
      #                          "codeSystemName" => "SNOMED CT")
      #                 xml.statusCode("code" => "completed")
      #               }  
      #             }
      #           end
      # 
      #           if status
      #             xml.entryRelationship("typeCode" => "REFR") {
      #               xml.observation("classCode" => "OBS", "moodCode" => "EVN") {
      #                 xml.code("code" => "33999-4", 
      #                          "displayName" => "Status", 
      #                          "codeSystem" => "2.16.840.1.113883.6.1", 
      #                          "codeSystemName" => "LOINC")
      #                 xml.statusCode("code" =>status)
      #                 xml.value("xsi:type" => "CE", 
      #                           "code" => "55561003", 
      #                           "displayName" => "Active", 
      #                           "codeSystem" => "2.16.840.1.113883.6.96", 
      #                           "codeSystemName" => "SNOMED CT")
      #               }
      #             }
      #           end
      # 
      #           if quantity_ordered_value  || quantity_ordered_unit  || expiration_time 
      #             xml.entryRelationship("typeCode" => "REFR") {
      #               xml.supply("classCode" => "SPLY", "moodCode" => "INT") {
      #                 xml.templateId("root" => "2.16.840.1.113883.3.88.1.11.32.11")
      #                 if quantity_ordered_unit 
      #                   xml.id("root" => quantity_ordered_unit, "extension" => "SCRIP#")
      #                 end 
      #                 if expiration_time 
      #                     xml.effectiveTime("value" => expiration_time.to_s(:brief))
      #                 end
      #                 if quantity_ordered_value 
      #                   xml.quantity("value" => quantity_ordered_value)
      #                 end  
      #               }
      #             }
      #           end
      # 
      #         }
      #       }
      #     end
      
    end
  end
end
