class HdataController <  ActionController::Base
  
  def not_implemented
     render :text => "Not Implemented", :status=>405
  end
  
  alias index not_implemented 
  alias create not_implemented 
  alias update not_implemented 
  alias delete not_implemented 
  
  def show
   @patient = Patient.find(params[:id])
   @extensions = [
     Extension.new("",true,[Extension::Section.new(  "patient_information/","Patient Information")]),
     Extension.new("",true,[Extension::Section.new(  "advance_directives/","Advance Directives")]),
     Extension.new("",true,[Extension::Section.new(  "conditions/","Conditions")]),
     Extension.new("",true,[Extension::Section.new(  "healthcare_providers/","Healthcare Provider")]),
     Extension.new("",true,[Extension::Section.new(  "procedures/","Procedures")]),
     Extension.new("",true,[Extension::Section.new(  "results/","Results")]),
     Extension.new("",true,[Extension::Section.new(  "vital_sings/","Vital Signs")])
     ]
  end
  


 class Extension
   
   attr_accessor :type_id
   attr_accessor :requirement
   attr_accessor :sections
   
   def initialize(type, requirement=false, sections=[])
     @type_id=type
     @requirement = requirement
     @sections = sections
     
   end
   
   class Section
     attr_accessor :path
     attr_accessor :name

     def initialize(path,name)
       @path = path
       @name = name
     end

   end
   
 end
 

  
end