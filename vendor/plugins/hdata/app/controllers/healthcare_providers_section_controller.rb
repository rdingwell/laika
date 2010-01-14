class HealthcareProvidersSectionController< SectionController
  

   
   def index
     @patient = Patient.find(params[:hdatum_id])
     @entries = @patient.providers
     render :partial=>"shared/atom.builder"
   end
   
   def show
     @patient = Patient.find(params[:hdatum_id])
     @entry = @patient.provider
     render :partial=>"shared/show.builder"
   end
end