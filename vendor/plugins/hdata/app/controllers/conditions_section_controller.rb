class ConditionsSectionController< SectionController
  
    @@atom_title = "Conditions"
   
   def index
     @patient = Patient.find(params[:hdatum_id])
     @entries = @patient.conditions
     render :partial=>"shared/atom.builder"
   end
   
   def show
     @patient = Patient.find(params[:hdatum_id])
     @entry = @patient.conditions.find(params[:id])
     render :partial=>"shared/show.builder"
   end
end