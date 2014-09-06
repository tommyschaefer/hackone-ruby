Gem::Specification.new do |s|
  s.name        = 'hackone'
  s.version     = '0.0.2'
  s.date        = '2014-09-03'
  s.summary     = "A gem to use for parsing CommonHack & HackOne JSON docs."
  s.description = "This gem is a ruby wrapper that similifies the parsing CommonHack and HackOne JSON. More information about HackOne can be seen at http://www.hackone.co and more information about CommonHack can be seen at http://commonhack.org"
  s.authors     = ["Marcus Yearwood", "Bilawal Hameed"]
  s.email       = 'bilawal@hackcard.org'
  s.files       = ["lib/hackone.rb"]
  s.homepage    =
    'http://github.com/hackcard/hackone-ruby'
  s.license       = 'MIT'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rspec-its'
end
