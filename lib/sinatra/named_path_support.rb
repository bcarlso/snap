require 'sinatra/base'

module Sinatra
  module Snap
    def self.registered(app)
      app.register PathDefinitionSupport
      app.helpers PathBuilderSupport
    end
  end

  module PathDefinitionSupport
    def self.registered(app)
      app.set :named_paths, {}
    end

    def paths(paths)
      paths.keys.each { | key | verify_type_of(key) }
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

  module UrlBuilder
    SPLAT = %r{(\*)}
    NAMED_PARAMETER = %r{/?(:\S+?)(?:/|$)}
    REGEXP_GROUP = %r{\(.+?\)}
    
    def with(*values)
      if self.instance_of? Regexp
        replace_regex_with(values)
      else
        replace_string_with(values)
      end
    end
  
    def replace_regex_with(values)
      perform_substitution_using(self.source, REGEXP_GROUP, values)
    end
  
    def perform_substitution_using(url, replacement_pattern, values) 
      string = String.new(url)
      string.scan(replacement_pattern).each_with_index do | placeholder, index |
        string.sub!(Regexp.new(Regexp.escape(placeholder.first)), values[index].to_s)
      end
      string
    end

    def replace_string_with(values)
      replacement_pattern = route_defined_using_splat? ? SPLAT : NAMED_PARAMETER
      perform_substitution_using(self, replacement_pattern, values)
    end
  
    def route_defined_using_splat?
      SPLAT.match self
    end
    
    private :replace_regex_with, :replace_string_with, :route_defined_using_splat?, :perform_substitution_using
  end

  module PathBuilderSupport
    def path_to path_name
      pattern = self.class.named_paths[path_name]
      raise ArgumentError.new("Unknown path ':#{path_name.to_s}'") if pattern == nil
      pattern.extend UrlBuilder
    end
  end
  
  register Snap
end
