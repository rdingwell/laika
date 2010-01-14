class PatientInformationSectionController< SectionController
  

   def index
     @patient = Patient.find(params[:hdatum_id])
     @entries = [@patient]
     render :partial=>"shared/atom.builder"
   end
   
   def show
     @entry = Patient.find(params[:hdatum_id])
     render :partial=>"shared/show.builder"
   end
end