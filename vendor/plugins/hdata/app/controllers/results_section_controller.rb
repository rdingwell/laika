class ResultsSectionController< SectionController
  

   
   def index
     @patient = Patient.find(params[:hdatum_id])
     @entries = @patient.results
     render :partial=>"shared/atom.builder"
   end
   
   def show
     @patient = Patient.find(params[:hdatum_id])
     @entry = @patient.results.find(params[:id])
     render :partial=>"shared/show.builder"
   end
end