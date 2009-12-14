ActionController::Routing::Routes.draw do |map|
 map.hdata_rt "/hdata/:id/root.xml" , :controller=>:hdata, :action=>:show, :method=>:get
  map.resources :hdata,:member   =>[:root =>:get] do |hd|
   
   [:medications].each do |section|
    controller = "#{section}_section".to_sym
    map.connect "/hdata/:hdatum_id/#{section}/section.xml", :controller => controller, :action=>:index, :method=>:get
    hd.resources section, :controller=>controller
  end
  end
 
  


end
