# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{snap}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["bcarlso"]
  s.date = %q{2009-08-07}
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
     "lib/snap.rb",
     "snap.gemspec",
     "spec/snap_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/bcarlso/snap}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
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
