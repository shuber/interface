require File.expand_path('../lib/interface/version', __FILE__)

Gem::Specification.new do |s|
  s.author           = 'Sean Huber'
  s.description      = 'Implementable interfaces in ruby'
  s.email            = 'github@shuber.io'
  s.extra_rdoc_files = %w(LICENSE)
  s.files            = `git ls-files`.split("\n")
  s.homepage         = 'https://github.com/shuber/interface'
  s.license          = 'MIT'
  s.name             = 'interface'
  s.rdoc_options     = %w(--charset=UTF-8 --inline-source --line-numbers --main README.rdoc)
  s.require_paths    = %w(lib)
  s.summary          = 'Implementable interfaces in ruby'
  s.test_files       = `git ls-files -- test/*`.split("\n")
  s.version          = Interface::VERSION

  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'rake'
end
