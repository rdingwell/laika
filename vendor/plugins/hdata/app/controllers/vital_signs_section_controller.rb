class VitalSignsSectionController< SectionController
  

   
   def index
     @patient = Patient.find(params[:hdatum_id])
     @entries = @patient.vital_signs
     render :partial=>"shared/atom.builder"
   end
   
   def show
     @patient = Patient.find(params[:hdatum_id])
     @entry = @patient.vital_signs.find(params[:id])
     render :partial=>"shared/show.builder"
   end
end