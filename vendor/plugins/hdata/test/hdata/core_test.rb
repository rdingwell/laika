require "#{File.dirname(__FILE__)}/../test_helper"
require 'rubygems'
require 'builder'
require 'hdata'
class CoreTest < Test::Unit::TestCase
  
  def test_person_to_hdata
    assert false
  end
  
  
  def test_address_to_hdata
    addr =  Address.new(:state=>"MA", :city=>"NBPT", :postal_code=>"01950" , :iso_country=>IsoCountry.find_by_code("us"), :street_address_line_one=>"line_one")
    xml =  Builder::XmlMarkup.new
    puts addr.to_hdata(xml)
    
    assert false
  end


end