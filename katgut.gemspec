$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "katgut/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "katgut"
  s.version     = Katgut::VERSION
  s.authors     = ["HAMADA Kazuki"]
  s.email       = ["hamada.kazuki.mum@gmail.com"]
  s.homepage    = "https://github.com/oishi-kenko/katgut"
  s.summary     = "A rails plugin to transfer incomming request to another URL."
  s.description = "It Sutures a URL onto another with a redirection path"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,public}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.required_ruby_version = '>= 2.3'

  s.add_dependency "rails", '>= 4.2.6'

  s.add_development_dependency "sqlite3", '~> 1.3'
  s.add_development_dependency "rspec-rails", '~> 3.4'
  s.add_development_dependency "factory_girl_rails", '~> 4.5'
  s.add_development_dependency "database_cleaner", '~> 1.5'
  s.add_development_dependency "pry-byebug", '~> 3.4'
  s.add_development_dependency "awesome_print", '~> 1.7'
end
