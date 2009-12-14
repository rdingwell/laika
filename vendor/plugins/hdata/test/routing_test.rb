require "#{File.dirname(__FILE__)}/test_helper"

# this next require is needed or else routing error cannot be  found
require "action_controller/base"
require "config/routes.rb"
class RoutingTest < Test::Unit::TestCase

  def setup

  end

  def test_hdata_routes
    assert_recognition :get, "/hdata", :controller => "hdata", :action => "index"
    assert_recognition :post, "/hdata", :controller => "hdata", :action => "create"
    
    assert_recognition :delete, "/hdata/1", :controller => "hdata", :action => "destroy", :id=>"1"
    assert_recognition :put, "/hdata/1", :controller => "hdata", :action => "update", :id=>"1"
   
    assert_recognition :get, "/hdata/1", :controller => "hdata", :action => "show", :id=>"1"
    assert_recognition :get, "/hdata/1/root.xml", :controller => "hdata", :action => "show", :id=>"1", :method=>:get
  end  

  def test_section_routes
    ["medications"].each do |section|
    assert_recognition :post, "/hdata/1/#{section}", :controller => "#{section}_section", :action => "create", :hdatum_id=>"1"
    assert_recognition :get, "/hdata/1/#{section}", :controller => "#{section}_section", :action => "index", :hdatum_id=>"1"

    assert_recognition :put, "/hdata/1/#{section}/1", :controller => "#{section}_section", :action => "update", :hdatum_id=>"1", :id=>"1"
    assert_recognition :get, "/hdata/1/#{section}/1", :controller => "#{section}_section", :action => "show",:hdatum_id=>"1", :id=>"1"
    assert_recognition :delete, "/hdata/1/#{section}/1", :controller => "#{section}_section", :action => "destroy", :hdatum_id=>"1", :id=>"1"

    assert_recognition :get, "/hdata/1/#{section}/section.xml", :controller => "#{section}_section", :action => "index", :hdatum_id=>"1",:method=>:get
    
  end
 
 end


  private

    # yes, I know about assert_recognizes, but it has proven problematic to
    # use in these tests, since it uses RouteSet#recognize (which actually
    # tries to instantiate the controller) and because it uses an awkward
    # parameter order.
    def assert_recognition(method, path, options)
      result = ActionController::Routing::Routes.recognize_path(path, :method => method)
      assert_equal options, result
    end
end