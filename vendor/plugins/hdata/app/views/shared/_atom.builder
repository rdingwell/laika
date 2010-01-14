xml.instruct! :xml, :version => '1.0'
xml.feed(:xmlns=>"http://www.w3.org/2005/Atom") do 

  xml.title "Example Feed"
  xml.id 
  @entries.each do |entry|
  entry.to_atom(xml)
  end
  
end