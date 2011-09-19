# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "iemodal/version"

Gem::Specification.new do |s|
  s.name        = "iemodal"
  s.version     = IEModal::VERSION
  s.authors     = ["Jeffrey S. Morgan"]
  s.email       = ["jeff.morgan@leandog.com"]
  s.homepage    = ""
  s.summary     = %q{Makes it possible to interact with modal dialogs in Internet Explorer}
  s.description = %q{Makes it possible to interact with modal dialogs in Internet Explorer}

  s.rubyforge_project = "iemodal"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'page-object'

  
  s.add_development_dependency 'rspec', '>= 2.6.0'
  s.add_development_dependency 'cucumber', '>= 1.0.0'
end
