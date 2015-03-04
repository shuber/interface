# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'interface/version'
require 'date'

Gem::Specification.new do |s|
  s.name     = 'shuber-interface'
  s.version  = Interface::Version
  s.date     = Date.today
  s.platform = Gem::Platform::RUBY

  s.summary     = 'Implementable interfaces in ruby'
  s.description = 'Implementable interfaces in ruby'

  s.author   = 'Sean Huber'
  s.email    = 'github@shuber.io'
  s.homepage = 'http://github.com/shuber/interface'

  s.require_paths = ['lib']

  s.files      = Dir['{bin,lib}/**/*'] + %w(LICENSE README.rdoc)
  s.test_files = Dir['test/**/*']

  s.add_dependency('respond_to_missing')
end
