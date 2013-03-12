require 'rspec'

RSpec.configure do |config|
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation

  def verify_route_added(verb, path)
      routes = @app.routes[verb]
      routes.size.should == 1
      routes[0][0].should match(path)
  end
end
