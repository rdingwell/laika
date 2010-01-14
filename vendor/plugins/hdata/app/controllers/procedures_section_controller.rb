class ProceduresSectionController< SectionController
  

   
   def index
     @patient = Patient.find(params[:hdatum_id])
     @entries = @patient.procedures
     render :partial=>"shared/atom.builder"
   end
   
   def show
     @patient = Patient.find(params[:hdatum_id])
     @entry = @patient.procedures.find(params[:id])
     render :partial=>"shared/show.builder"
   end
end