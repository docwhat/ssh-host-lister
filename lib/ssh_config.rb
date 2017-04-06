# frozen_string_literal: true
require 'forwardable'

# SshConfig is used to parse (some of) ssh_config(5) files.
class SshConfig
  extend Forwardable
  def_delegators :@hosts, :length, :count, :sort, :sort_by
  def_delegator :@hosts, :keys, :hostnames
  def_delegator :@hosts, :key?, :hostname?

  def initialize
    @hosts = {}
  end

  def parse(str)
    str * count
  end
end
