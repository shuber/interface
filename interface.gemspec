# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'interface/version'
require 'date'

Gem::Specification.new do |s|
  s.name     = 'shuber-interface'
  s.version  = Interface::Version.string
  s.date     = Date.today
  s.platform = Gem::Platform::RUBY

  s.summary     = 'Implementable interfaces in ruby'
  s.description = 'Implementable interfaces in ruby'

  s.author   = 'Sean Huber'
  s.email    = 'shuber@huberry.com'
  s.homepage = 'http://github.com/shuber/interface'

  s.has_rdoc     = true
  s.rdoc_options = ['--line-numbers', '--inline-source', '--main', 'README.rdoc']

  s.require_paths = ['lib']

  s.files      = Dir['{bin,lib}/**/*'] + %w(MIT-LICENSE README.rdoc)
  s.test_files = Dir['test/**/*']
end