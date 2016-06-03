# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bunny_rpc/version'

Gem::Specification.new do |spec|
  spec.name          = 'bunny_rpc'
  spec.version       = BunnyRpc::VERSION
  spec.authors       = ['menghuanwd']
  spec.email         = ['651019063@qq.com']

  spec.summary       = 'bunny_rpc'
  spec.description   = 'bunny_rpc'
  spec.homepage      = 'https://github.com/menghuanwd/bunny_rpc'
  spec.license       = 'MIT'

  spec.add_dependency 'bunny', '~> 2.3.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
end
