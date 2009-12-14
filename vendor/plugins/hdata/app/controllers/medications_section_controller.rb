class MedicationsSectionController< ActionController::Base
  
   def not_implemented
      render :text => "Not Implemented", :status=>405
   end

   alias index not_implemented 
   alias create not_implemented 
   alias update not_implemented 
   alias delete not_implemented
   alias show not_implemented
   
   def index
     @patient = Patient.find(params[:hdatum_id])
     @medications = @patient.medications
   end
end