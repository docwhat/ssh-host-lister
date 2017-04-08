# frozen_string_literal: true
require 'ssh_config/entry'

module SshConfig
  # For loading an ssh_config(5) file.
  class Loader
    def parse(str)
      pr = ParseRun.new

      str
        .to_str
        .split(/[\n\r]+/)
        .each do |line|

          pr.parse_host(Regexp.last_match(1)) if line =~ /^\s*Host\s+(.*)/
        end

      pr.results
    end
  end

  # Internal method for parsing
  class ParseRun
    def parse_host(arg)
      hosts = arg
        .split(/\s+/)
        .reject { |host| host =~ /^\d|%|\*/ }

      return if hosts.empty?
      entry = Entry.new(hosts)
      entry.distinct_names.each { |host| results[host] = entry }
    end

    def results
      @results ||= {}
    end

    private

    attr_writer :entry

    def entry
      @entry ||= nil
    end
  end
end
