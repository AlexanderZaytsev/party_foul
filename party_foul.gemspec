$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "party_foul/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "party_foul"
  s.version     = PartyFoul::VERSION
  s.authors     = ["Brian Cardarella", 'Dan McClain']
  s.email       = ["bcardarella@gmail.com", 'rubygems@danmcclain.net']
  s.homepage    = "https://github.com/dockyard/party_foul"
  s.summary     = "Auto-submit Rails exceptions as new isues on Github"
  s.description = "Auto-submit Rails exceptions as new isues on Github"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"

  s.add_development_dependency "sqlite3"
end