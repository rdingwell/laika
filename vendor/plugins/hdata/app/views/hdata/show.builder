xml.instruct! :xml, :version => '1.0'
xml.root(:xmlns => "http://projecthdata.org/hdata/schemas/2009/06/core") do
  xml.documentId(@patient.id)
  xml.version('0.8')
  xml.created(@patient.created_at.strftime("%Y-%m-%d"))
  xml.lastModified(Time.now.strftime("%Y-%m-%d")) #hack
  xml.extensions do
    @extensions.each do |extension|
      xml.extension(extension.type_id, :requirement => extension.requirement)
    end
  end
  xml.sections do
    @extensions.each do |extension|
      extension.sections.each do |section|
        xml.section(:typeId => extension.type_id, :path => section.path, :name => section.name)
      end
    end
  end
  
end