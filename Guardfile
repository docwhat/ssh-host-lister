# frozen_string_literal: true
# https://github.com/guard/guard#readme

group :red_green_refactor, halt_on_fail: true do
  guard(
    :rspec,
    cmd: 'bundle exec rspec --order defined --format doc',
    all_on_start: true,
    all_after_pass: true
  ) do
    require 'guard/rspec/dsl'
    dsl = Guard::RSpec::Dsl.new(self)

    dsl.rspec.tap do |rspec|
      watch(rspec.spec_helper) { rspec.spec_dir }
      watch(rspec.spec_support) { rspec.spec_dir }
      watch(rspec.spec_files)
    end

    dsl.ruby.tap do |ruby|
      dsl.watch_spec_files_for(ruby.lib_files)
    end
  end

  guard :rubocop do
    watch(/.+\.rb$/)
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end
end
