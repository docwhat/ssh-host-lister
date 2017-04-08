# frozen_string_literal: true
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:rubocop)

namespace 'gem' do
  require 'bundler/gem_tasks'
  # Remove tasks that Travis does for us...
  Rake::Task['release'].clear
end

task default: [:spec, :rubocop]
