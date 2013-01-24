$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "toy-verbs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "toy-verbs"
  s.version     = ToyVerbs::VERSION
  s.authors     = ["Christian Mortaro"]
  s.email       = ["christian.mortaro@gmail.com"]
  s.homepage    = "https://github.com/Mortaro/Toy-Verbs"
  s.summary     = "Handles the routing verbs for Toy-Locomotive"
  s.description = "Allows to use routing verbs directly inside a Rails controller"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_development_dependency "rails"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "sqlite3"
end
