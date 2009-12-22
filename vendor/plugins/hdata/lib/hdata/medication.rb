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

      def to_hdata(xml)

        xml.instruct! :xml, :version => '1.0'
        xml.medication(:xmlns => "http://projecthdata.org/hdata/schemas/2009/06/medication",
        "xmlns:core" => Hdata::Core::NAMESPACE) do

          if start_event.present?
            xml.effectiveTime( start_event.to_s(:brief))
          end
          if end_event.present?
            xml.effectiveTime( end_event.to_s(:brief))
          end

          xml.medicationInformation do 
            xml.manufacturedMaterial do
              xml.codedProductName( "code" => product_code, 
                                    "displayName" => product_coded_display_name, 
                                    "codeSystem" => code_system.code, 
                                    "codeSystemName" => code_system.name) do 
                xml.codedBrandName(:code=>"", :codeSystem=>"",:displayName => "")
                xml.freeTextProductName free_text_brand_name if free_text_brand_name
              end  
              xml.freeTextBrandName free_text_brand_name if free_text_brand_name
            end                
          end

          if medication_type.present

            xml.medicationType("code" => medication_type.code, 
                                "displayName" => medication_type.name, 
                                "codeSystem" => "2.16.840.1.113883.6.96", 
                               "codeSystemName" => "SNOMED CT")
          end
          if status
            xml.statusOfMedication(:code=>"", :codeSystem=>"",:displayName => "")
          end
          xml.orderInformation do
            if quantity_ordered_value  || quantity_ordered_unit 
              xml.quantityOrdered(:unit=>quantity_ordered_unit, :value=>quantity_ordered_value)
            end
            xml.orderExperationTime expiration_time if expiration_time
          end
        end
  
      end
    
    end
  end
end
