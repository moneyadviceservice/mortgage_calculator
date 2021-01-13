$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mortgage_calculator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mortgage_calculator"
  s.version     = MortgageCalculator::Version::STRING
  s.authors     = ["Team D"]
  s.email       = ["team.d@moneyhelper.org"]
  s.homepage    = "http://www.moneyhelper.org"
  s.summary     = "A Mortgage Calculator"
  s.description = "A Mortgage Calculator"

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["LICENSE", "Rakefile", "README.md", "bower.json.erb"] - Dir["vendor/assets/bower_components/**/*"]
  s.test_files = Dir["spec/**/*", "features/**/*"]

  s.add_dependency "rails", ">= 4", "< 5"
  s.add_dependency "sass-rails"
  s.add_dependency "modernizr-rails"
  s.add_dependency "angularjs-rails", '~> 1.2.18'
  s.add_dependency "underscore-rails"
  s.add_dependency "dough-ruby", "~> 5.36"
  s.add_dependency "mas-fonts"
  s.add_dependency "sprockets", "< 4"
end
