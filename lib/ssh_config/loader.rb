# frozen_string_literal: true
require 'ssh_config/entry'

module SshConfig
  # For loading an ssh_config(5) file.
  class Loader
    def parse(str)
      parse_lines(str.to_str.split(/[\n\r]+/))
    end

    def parse_lines(strings)
      Array(strings).map(&:to_str).each do |line|
        p_include(Regexp.last_match(1)) if line =~ /^\s*Include\s+(.*)/
        p_host(Regexp.last_match(1)) if line =~ /^\s*Host\s+(.*)/
      end

      results
    end

    def results
      @results ||= {}
    end

    private

    def p_host(arg)
      hosts = arg
        .split(/\s+/)
        .reject { |host| host =~ /^\d|%|\*/ }

      add_entry(Entry.new(hosts)) unless hosts.empty?
    end

    def p_include(glob)
      old_dir = Dir.pwd
      begin
        Dir.chdir File.expand_path('~/.ssh')
        Dir[glob.chomp].each do |fname|
          parse(File.read(fname))
        end
      ensure
        Dir.chdir old_dir
      end
    end

    def add_entry(entry)
      entry.distinct_names.each { |host| results[host] = entry }
    end
  end
end
