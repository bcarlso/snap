$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'spec'
require 'rubygems'
require 'sinatra/named_path_support'

Spec::Runner.configure do |config|
  def create_and_register_snap
    @app = Sinatra.new
    @app.register Sinatra::PathDefinitionSupport
    @app.helpers Sinatra::PathBuilderSupport
  end
  
  def verify_route_added(verb, path)
    routes = @app.routes[verb]
    routes.size.should == 1
    routes[0][0].should match(path)
  end
end
