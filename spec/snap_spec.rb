require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'sinatra/base'
require 'rack/test'

describe "Snap DSL extensions" do
  before :each do
    create_and_register_snap
  end
  
  it "should extend the route method to support passing in symbols" do
    @app.path :home => 'homepage'
    @app.get :home do
      'irrelavent'
    end

    verify_route_added('GET', 'homepage')
  end
  
  it "should initialize the named paths collection when registered" do
    @app.named_paths.should be_empty
  end
  
  it "should register a new named path when the path method is called" do
    @app.path :name => '/url'
    @app.named_paths.should == { :name => '/url' }
  end

  it "should register a collection of named paths when the paths method is called" do
    @app.paths :names => '/url',
               :other_name => '/other_url'
    @app.named_paths.should == { :names => '/url',
                                 :other_name => '/other_url' }
  end

  it "should only allow symbols to be passed in as the first parameter of a path call" do
    begin
      @app.path 'anything other than a symbol', '/irrelavent-for-this-test'
      fail
    rescue ArgumentError
    end
  end
  
  it "should only allow symbols to be passed in as the key to the paths hash" do
    begin
      @app.paths 'anything other than a symbol' => '/irrelavent-for-this-test',
                 :name => '/also-irrelavent'
      fail
    rescue ArgumentError
    end
  end
end

describe "Snap helper methods for building URLs" do
  before :each do
    create_and_register_snap
  end

  it "should return a simple path using path_to" do
    @app.path :name => '/url'
    @app.new.path_to(:name).should == '/url'
  end
  
  it "should retrieve a path by key and perform parameter substitution" do
    @app.path :users => '/users/:name/tags/:tag'
    @app.new.path_to(:users).with('bcarlso', 'sinatra').should == '/users/bcarlso/tags/sinatra'
  end
  
  it "should retrieve a path by key and perform parameter substitution on numeric values" do
    @app.path :users => '/users/:id'
    @app.new.path_to(:users).with(15).should == '/users/15'
  end
  
  it "should retrieve a path by key and perform parameter substitution on consecutive placeholders" do
    @app.path :users => '/users/:id/:age'
    @app.new.path_to(:users).with(15, 23).should == '/users/15/23'
  end
end

describe "Snap auto registration capabilities" do
  it "should register the DSL extension when included"
  it "should register the helper methods when included"
end