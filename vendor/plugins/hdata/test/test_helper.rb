require 'rubygems'
require 'active_support'
require 'actionpack'
require "action_controller"
require 'action_controller/test_process'
require 'logger'
#require 'test/unit'
require "shoulda"
require 'active_support/test_case'

require "#{File.dirname(__FILE__)}/../init"
ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))
require 'rexml/document'
require 'xml_helper'

SCHEMA_VALIDATORS = {}

def get_schema_validator(schema)
  unless SCHEMA_VALIDATORS[schema]
    SCHEMA_VALIDATORS[schema] = Validators::Schema::Validator.new(schema, "#{::HDATA_SCHEMA_DIRECTORY}/2009/06/#{schema}.xsd") 
  end
  
  SCHEMA_VALIDATORS[schema]
end

def assert_schema_validation(schema, xml)
 validator = get_schema_validator(schema)
 errors = validator.validate(nil,xml)
 unless errors.empty?  
  puts xml 
  puts errors.map{|e| e.error_message} if !errors.empty?
 end
 assert errors.empty?
end


def assert_recognition(method, path, options)
  result = ActionController::Routing::Routes.recognize_path(path, :method => method)
  assert_equal options, result
end


def assert_xml_match(xml,path,value,namespaces={},bind_variables = {},format= :small )
  error = XmlHelper.match_value(xml,path,value,namespaces,bind_variables,format)
  puts error if error
  assert error.nil?
end


