# frozen_string_literal: true

require 'ssh_config/loader.rb'

# A module for listing out ssh_config(5)
module SshConfig
  module_function

  def default_loader
    @default_loader ||= Loader.new
  end

  def load_defaults
    {}.tap do |result|
      %w(/etc/ssh/ssh_config ~/.ssh/config)
        .map { |path| File.expand_path path }
        .select { |path| File.readable? path }
        .each do |path|
          result.merge! default_loader.parse(File.read(path))
        end
    end
  end
end
