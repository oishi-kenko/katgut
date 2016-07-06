$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "toritsugi/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "toritsugi"
  s.version     = Toritsugi::VERSION
  s.authors     = ["HAMADA Kazuki"]
  s.email       = ["kazuki-hamada@cookpad.com"]
  s.homepage    = "https://kenko.cookpad.com/"
  s.summary     = "A rails plugin to transfer incomming request to apropriate URL."
  s.description = "Yet another reredirector"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "sqlite3"
end
