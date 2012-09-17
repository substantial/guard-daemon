# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/daemon/version'

Gem::Specification.new do |gem|
  gem.name          = "guard-daemon"
  gem.version       = Guard::DaemonVersion::VERSION
  gem.authors       = ["re5et"]
  gem.email         = ["re5etsmyth@gmail.com"]
  gem.description   = %q{Guard plugin to daemonize commands, and to start and stop them}
  gem.summary       = %q{Guard plugin to daemonize commands, and to start and stop them}
  gem.homepage      = "https://github.com/substantial/guard-daemon"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency('guard')
  gem.add_dependency('rainbow')
end
