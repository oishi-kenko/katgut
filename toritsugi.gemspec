$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "toritsugi/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "toritsugi"
  s.version     = Toritsugi::VERSION
  s.authors     = ["HAMADA Kazuki"]
  s.email       = ["hamada.kazuki.mum@gmail.com"]
  s.homepage    = "https://kenko.cookpad.com/"
  s.summary     = "A rails plugin to transfer incomming request to another URL."
  s.description = "Yet another reredirector"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,public}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
end
