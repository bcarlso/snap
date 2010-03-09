# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sinatra-snap}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["bcarlso"]
  s.date = %q{2010-03-06}
  s.email = %q{bcarlso@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "examples/named_route_example.rb",
     "lib/sinatra/named_path_support.rb",
     "lib/sinatra-snap.rb",
     "sinatra-snap.gemspec",
     "spec/snap_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/bcarlso/sinatra-snap}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Sinatra NAmed Path support}
  s.test_files = [
    "spec/snap_spec.rb",
     "spec/spec_helper.rb",
     "examples/named_route_example.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
