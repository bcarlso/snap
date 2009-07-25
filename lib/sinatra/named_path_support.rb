require 'sinatra/base'

module Sinatra
  module PathDefinitionSupport
    def path name, pattern
      named_paths[name] = pattern
    end

    def route(verb, path, options={}, &block)
      path = named_paths[path] if path.kind_of? Symbol
      super verb, path, options, &block
    end
    
    def self.registered(app)
      app.set :named_paths, {}
    end
  end 

  module PathBuilderSupport
    def path_to path_name
      pattern = self.class.named_paths[path_name]
      def pattern.with(*values)
        url = String.new(self)
        index = 0;
        scan(%r{/?(:\S+?)(?:/|$)}).each do | placeholder |
          url.gsub!(Regexp.new(placeholder[0]), values[index].to_s)
          index += 1
        end
        url
      end
      pattern
    end
  end
  
  register PathDefinitionSupport
  helpers PathBuilderSupport
end
