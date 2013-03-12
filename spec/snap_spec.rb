require_relative 'spec_helper'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'sinatra/base'
require 'sinatra/snap'

require 'rack/test'

describe Sinatra::Snap do
  before :each do
    @app = Sinatra.new do
      register Sinatra::Snap
    end
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

  it "should register a named path in route definition with hash" do
    @app.get :home => 'homepage' do
      'irrelavent'
    end

    verify_route_added('GET', 'homepage')
  end

  it "should raise ArgumentError when registering multiple paths in one route definition" do
    expect do
      @app.get :home => 'test', :bam => 'test1' do
        'error'
      end
    end.to raise_error(ArgumentError)
  end
end

describe Sinatra::Snap::Helpers do
  before :each do
    @app = Sinatra.new do
      register Sinatra::Snap
    end

    def helper_context &block
      @app.class_eval do
        get('/', &block)
      end
    end
  end

  it "should return a simple path using path_to" do
    @app.path :name => '/url'
    helper_context do
      path_to(:name).should eq('/url')
    end
  end
  
  it "should retrieve a path by key and perform parameter substitution" do
    @app.path :users => '/users/:name/tags/:tag'
    helper_context do
      path_to(:users).with('bcarlso', 'sinatra').should == '/users/bcarlso/tags/sinatra'
    end
  end
  
  it "should retrieve a path by key and perform parameter substitution on numeric values" do
    @app.path :users => '/users/:id'
    helper_context do
      path_to(:users).with(15).should == '/users/15'
    end
  end
  
  it "should retrieve a path by key and perform parameter substitution on consecutive placeholders" do
    @app.path :users => '/users/:id/:age'
    helper_context do
      path_to(:users).with(15, 23).should == '/users/15/23'
    end
  end
  
  it "should retrieve a path defined as a regex and perform parameter substitution" do
    @app.path :users => %r{/users/(\d+)}
    helper_context do
      path_to(:users).with(15).should == '/users/15'
    end
  end
  
  it "should retrieve a path defined as a regex and perform parameter substitution on consecutive parameters" do
    @app.path :users => %r{/users/(\d+)/(foo|bar)}
    helper_context do
      path_to(:users).with(15, 'foo').should == '/users/15/foo'
    end
  end
  
  it "should support splat syntax" do
    @app.path :say => '/say/*/to/*'
    helper_context do
      path_to(:say).with('hi', 'bob').should == '/say/hi/to/bob'
    end
  end
  
  it "should still support splat syntax" do
    @app.path :say => '/download/*.*'
    helper_context do
      path_to(:say).with('path/to/file', 'xml').should == '/download/path/to/file.xml'
    end
  end
  
  it "should raise a friendly error when the path doesn't exist" do
    helper_context do 
      expect do
        path_to(:unknown)
      end.should raise_error(ArgumentError)
    end
  end
end