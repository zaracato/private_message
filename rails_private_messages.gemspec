$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "private_messages/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_private_messages"
  s.version     = PrivateMessages::VERSION
  s.authors     = ["Arturo Hernandez"]
  s.email       = ["ahernandez@engranedigital.com"]
  s.homepage    = "http://zaracato.com"
  s.summary     = "Manage simple messages from users in a rails app"
  s.description = "Many of this code was taked from https://github.com/jongilbraith/simple-private-messages gem"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"

  s.add_development_dependency "sqlite3"
end
