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
   @extensions = []
  end
  

  
end