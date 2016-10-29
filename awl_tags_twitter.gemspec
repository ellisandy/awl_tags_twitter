# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'awl_tags_twitter/version'

Gem::Specification.new do |spec|
  spec.name          = 'awl_tags_twitter'
  spec.version       = AwlTagsTwitter::VERSION
  spec.authors       = ['Jack Ellis']
  spec.email         = ['jack@mnmlst.cc']
  spec.summary       = 'Grab tags from The Awl posts and tweet them out'
  spec.description   = 'Grab tags from The Awl posts and tweet them out'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'nokogiri', '~> 1.6.6'
  spec.add_runtime_dependency 'commander', '~> 4.3'
  spec.add_runtime_dependency 'terminal-table', '~> 1.5'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'rspec-mocks', '~> 3.2'
  spec.add_development_dependency 'yard', '~> 0.8'
  spec.add_development_dependency 'rubocop', '~> 0.8'
  spec.add_development_dependency 'webmock', '~> 1.22'
  spec.add_development_dependency 'vcr', '~> 2.9'
  spec.add_development_dependency 'simplecov', '~> 0.10'
  spec.add_development_dependency 'guard-rspec', '~> 4.5'
  spec.add_development_dependency 'terminal-notifier-guard', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
end
