# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mecha/version'

Gem::Specification.new do |spec|
  spec.name          = 'mecha'
  spec.version       = Mecha::VERSION
  spec.authors       = ['Magrathea Labs']
  spec.email         = ['contact@magrathealabs.com']

  spec.summary       = 'Generate a Rails app using MLabs defaults.'
  spec.description   = 'Mecha is used by MLabs to bootstrap working apps with our defaults.'
  spec.homepage      = 'https://github.com/magrathealabs/mecha'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = ['mecha']
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.3.3'

  spec.add_dependency 'rails', '>= 5.1.4', '< 5.3.0'
  spec.add_dependency 'slop', '>= 4.5.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'rake'
end
