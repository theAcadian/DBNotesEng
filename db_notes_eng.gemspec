$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "db_notes_eng/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "db_notes_eng"
  s.version     = DbNotesEng::VERSION
  s.authors     = ["theAcadian"]
  s.email       = ["sai_ponduru@yahoo.com"]
  s.homepage    = "http://psjplearn.blogspot.com"
  s.summary     = "Database Notes Engine"
  s.description = "Database Notes Engine"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.x"
  # s.add_dependency "jquery-rails"
  s.add_dependency "IcentrisJira"

  s.add_development_dependency "sqlite3"
end
