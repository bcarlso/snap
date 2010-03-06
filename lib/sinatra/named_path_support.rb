require 'sinatra/base'

module Sinatra
  module PathDefinitionSupport
    def self.registered(app)
      app.set :named_paths, {}
    end

    def paths(paths)
      paths.keys.each { | k | verify_type_of(k) }
      named_paths.merge!(paths)
    end

    alias_method :path, :paths
    
    def route(verb, path, options={}, &block)
      path = named_paths[path] if path.kind_of? Symbol
      super verb, path, options, &block
    end
    
    def verify_type_of(name)
      raise ArgumentError.new('Path name must be a symbol') unless name.kind_of?(Symbol) 
    end

    private :verify_type_of
  end 

  module PathBuilderSupport
    def path_to path_name
      pattern = self.class.named_paths[path_name]
      def pattern.with(*values)
        if self.instance_of? Regexp
          url = String.new(self.source)
          self.source.scan(%r{\(.+?\)}).each_with_index do | placeholder, index |
              url.sub!(Regexp.new(Regexp.escape(placeholder)), values[index].to_s)
          end
        else
          url = String.new(self)
          scan(%r{/?(:\S+?)(?:/|$)}).each_with_index do | placeholder, index |
            url.gsub!(Regexp.new(placeholder[0]), values[index].to_s)
          end
        end
        url
      end
      pattern
    end
  end
  
  register PathDefinitionSupport
  helpers PathBuilderSupport
end
