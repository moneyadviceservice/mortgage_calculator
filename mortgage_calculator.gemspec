$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mortgage_calculator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mortgage_calculator"
  s.version     = MortgageCalculator::Version::STRING
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MortgageCalculator."
  s.description = "TODO: Description of MortgageCalculator."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*", "features/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "jquery-rails"
  s.add_dependency "angularjs-rails", "1.2.10"
  s.add_dependency "underscore-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "mas-development_dependencies"
end
