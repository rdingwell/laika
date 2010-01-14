# Hdata
Dir.glob(File.join(File.dirname(__FILE__), 'hdata/*.rb')).each {|f| require_dependency f }
Dir.glob(File.join(File.dirname(__FILE__), 'hdata/translation/*.rb')).each {|f| require_dependency f }
module Hdata
  
  def self.include_data_modules
    Language.send :include, Hdata::Core::Language
    MaritalStatus.send :include, Hdata::Core::MaritalStatus
    Telecom.send :include, Hdata::Core::Telecom
    Address.send :include , Hdata::Core::Address
    Gender.send :include, Hdata::Core::Gender
    PersonName.send :include, Hdata::Core::PersonName
    Race.send :include, Hdata::Core::Race
    Patient.send :include, Hdata::Translation::Patient
    AdvanceDirective.send :include, Hdata::Translation::AdvanceDirective
    Allergy.send :include, Hdata::Translation::Allergy
    Condition.send :include, Hdata::Translation::Condition
    Encounter.send :include, Hdata::Translation::Encounter
    Provider.send :include, Hdata::Translation::HealthcareProvider
    Immunization.send :include, Hdata::Translation::Immunization
    InsuranceProvider.send :include, Hdata::Translation::InsuranceProvider
    Medication.send :include, Hdata::Translation::Medication
    Procedure.send :include, Hdata::Translation::Procedure
    AbstractResult.send :include , Hdata::Translation::AbstractResult
    Result.send :include, Hdata::Translation::Result
    VitalSign.send :include, Hdata::Translation::VitalSign
    Support.send :include, Hdata::Translation::Support
  end
  
end

ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge! ( 

  :iso8601 => "%FT%T",
  :xmlDate => "%F"
)
Hdata.include_data_modules