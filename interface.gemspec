require 'date'
require 'lib/interface/version'

Gem::Specification.new do |s| 
  s.name    = 'shuber-interface'
  s.version = Interface::Version.string
  s.date    = Date.today.to_s

  s.summary     = 'Implementable interfaces in ruby'
  s.description = 'Implementable interfaces in ruby'

  s.author   = 'Sean Huber'
  s.email    = 'shuber@huberry.com'
  s.homepage = 'http://github.com/shuber/interface'

  s.has_rdoc = false
  s.rdoc_options = ['--line-numbers', '--inline-source', '--main', 'README.rdoc']

  s.require_paths = ['lib']

  s.files = %w(
    lib/interface.rb
    lib/interface/abstract.rb
    lib/interface/test_helper.rb
    lib/interface/version.rb
    lib/shuber-interface.rb
    MIT-LICENSE
    Rakefile
    README.rdoc
    test/interface_test.rb
    test/test_helper.rb
  )

  s.test_files = %w(
    test/interface_test.rb
    test/test_helper.rb
  )
end