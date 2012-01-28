# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "cage"
  s.version     = "0.1.0"
  s.authors     = ["Steven! Ragnarök"]
  s.email       = ["steven@nuclearsandwich.com"]
  s.homepage    = "https://github.com/nuclearsandwich/cage"
  s.summary     = "A Faraday Cage for your HTTP Interactions."
  s.description = <<-DESC
Curl can be a bit unfriendly, especially to developers just starting out. Cage
wraps Faraday and Pry in order to provide an attractive and helpful interface to
the web APIs in your life.
  DESC

  s.files         = %w[lib/cage.rb lib/cage/console.rb lib/cage/version.rb lib/cage/response.rb]
  s.test_files    = %w[test/day9.xml test/rails-gem.json test/response_test.rb test/console_test.rb]
  s.executables   = %w[cage]
  s.require_paths = %w[lib]

  s.add_development_dependency "rake"
  s.add_development_dependency "minitest"
  s.add_development_dependency "mustache"
  s.add_runtime_dependency "faraday"
  s.add_runtime_dependency "faraday_middleware"
  s.add_runtime_dependency "multi_xml"
  s.add_runtime_dependency "json"
  s.add_runtime_dependency "nokogiri"
  s.add_runtime_dependency "pry"
  s.add_runtime_dependency "awesome_print"
end
