class AdvanceDirectivesSectionController< SectionController
  
  @@atom_title = "Advance Directives"
   
   def index
     @patient = Patient.find(params[:hdatum_id])
     @entries = [@patient.advance_directive]
     
     render :partial=>"shared/atom.builder"
   end
   
   def show
     @patient = Patient.find(params[:hdatum_id])
     @entry = @patient.advance_directive
     render :partial=>"shared/show.builder"
   end
end