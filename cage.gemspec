# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cage/version"

Gem::Specification.new do |s|
  s.name        = "cage"
  s.version     = Cage::VERSION
  s.authors     = ["Steven! Ragnarök"]
  s.email       = ["steven@nuclearsandwich.com"]
  s.homepage    = "https://github.com/nuclearsandwich/cage"
  s.summary     = "A Faraday Cage for your HTTP Interactions."
  s.description = <<-DESC
Curl can be a bit unfriendly, especially to developers just starting out. Cage
wraps Faraday and Pry in order to provide an attractive and helpful interface to
the web APIs in your life.
  DESC

  s.files         = Dir["lib/**/*"] + ["README.md", "cage.gemspec"]
  s.test_files    = Dir["test/**/*"]
  s.executables   = %w[bin/cage].map{ |f| File.basename f }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
  s.add_runtime_dependency "faraday"
  s.add_runtime_dependency "multi_json"
  s.add_runtime_dependency "nokogiri"
  s.add_runtime_dependency "pry"
  s.add_runtime_dependency "awesome_print"
end
