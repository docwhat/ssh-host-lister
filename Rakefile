# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'reek/rake/task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:rubocop)
Reek::Rake::Task.new(:reek)

namespace 'gem' do
  require 'bundler/gem_tasks'
  # Remove tasks that Travis does for us...
  Rake::Task['release'].clear
end

task default: %i[spec rubocop reek]
