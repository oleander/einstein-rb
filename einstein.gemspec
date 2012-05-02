# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "einstein/version"

Gem::Specification.new do |s|
  s.name        = "einstein"
  s.version     = Einstein::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Linus Oleander"]
  s.email       = ["linus@oleander.nu"]
  s.homepage    = "git@github.com:oleander/einstein-rb.git"
  s.summary     = %q{Push notification service for restaurant Einstein}
  s.description = %q{Push notification service for restaurant Einstein.}

  s.rubyforge_project = "einstein"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency("rest-client")
  s.add_dependency("nokogiri")
  s.add_dependency("prowl")
  s.add_dependency("titleize")
    
  s.add_development_dependency("rspec")
  s.add_development_dependency("webmock")
  s.add_development_dependency("vcr")
  
  s.required_ruby_version = ">= 1.9.0"
end
