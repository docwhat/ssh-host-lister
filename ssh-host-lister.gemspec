# coding: utf-8
# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'ssh-host-lister'
  spec.version       = '0.3.0'
  spec.authors       = ['Christian Höltje']
  spec.email         = ['docwhat@gerf.org']

  spec.summary       = 'Lists unique, short host names ssh_config(5)'
  spec.description   = 'Generates a list of host names for ssh_config(5) suitable for shell completion or via fzf.'
  spec.homepage      = 'https://github.com/docwhat/ssh-host-lister'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.3'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 11.3'

  spec.add_development_dependency 'reek', '~> 4.5'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.47.1'

  spec.add_development_dependency 'guard', '~> 2.14'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'guard-rubocop', '~> 1.2'

  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0.0'
end
