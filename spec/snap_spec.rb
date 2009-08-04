require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'sinatra/base'

class SinatraApp < Sinatra::Base
  register Sinatra::PathDefinitionSupport
end

describe "Snap" do
  after :all do
    SinatraApp.named_paths = {}
  end
  
  it "should extend the route method to support passing in symbols"
  it "should register the DSL extension when included"
  it "should register the helper methods when included"

  it "should initialize the named paths collection when registered" do
    SinatraApp.named_paths.should be_empty
  end
  
  it "should register a new named path when the path method is called" do
    SinatraApp.class_eval do
      path :name, '/url'
    end
    SinatraApp.named_paths.should == { :name => '/url' }
  end

  it "should register a collection of named paths when the paths method is called" do
    SinatraApp.class_eval do
      paths :name => '/url',
            :other_name => '/other_url'
    end
    SinatraApp.named_paths.should == { :name => '/url',
                                       :other_name => '/other_url' }
  end

  it "should only allow symbols to be passed in as the first parameter of a path call" do
    begin
      SinatraApp.class_eval do
        path 'anything other than a symbol', '/irrelavent-for-this-test'
      end
      fail
    rescue ArgumentError
    end
  end
  
  it "should only allow symbols to be passed in as the key to the paths hash" do
    begin
      SinatraApp.class_eval do
        paths 'anything other than a symbol' => '/irrelavent-for-this-test',
              :name => '/also-irrelavent'
      end
      fail
    rescue ArgumentError
    end
  end
end
