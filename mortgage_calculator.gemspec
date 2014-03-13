$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mortgage_calculator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mortgage_calculator"
  s.version     = MortgageCalculator::Version::STRING
  s.authors     = ["Team D"]
  s.email       = ["team.d@moneyadviceservice.org.uk"]
  s.homepage    = "http://www.moneyadviceservice.co.uk"
  s.summary     = "A Mortgage Calculator"
  s.description = "A Mortgage Calculator"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*", "features/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "jquery-rails"
  s.add_dependency "jquery-ui-rails"
  s.add_dependency "angularjs-rails", '1.2.13'
  s.add_dependency "underscore-rails"
  s.add_dependency "mas-assets"
  s.add_dependency "mas-feedback"
  s.add_dependency "mas-templating"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "mas-development_dependencies"
  s.add_development_dependency "simplecov"
end
