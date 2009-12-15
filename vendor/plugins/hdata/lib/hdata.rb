# Hdata
Dir.glob(File.join(File.dirname(__FILE__), 'hdata/*.rb')).each {|f| require_dependency f }
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
  end
  
end

Hdata.include_data_modules