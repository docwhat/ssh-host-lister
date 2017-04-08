# frozen_string_literal: true

module SshConfig
  # SshHost represents a single Host entry in an ssh_config(5)
  class Entry
    attr_reader :user

    def initialize(*names)
      @names = Array(names).flatten.map { |name| String(name) }
    end

    def distinct_names
      @distinct_names ||= begin
        no_ips = @names
          .sort(&:count)
          .reject { |name| name =~ /\A\d+\.\d+\.\d+\.\d+\Z/ }

        no_ips
          .reject do |name|
            parts = name.split('.')
            parts.count != 1 && no_ips.include?(parts.first)
          end
      end
    end

    def user=(val)
      @user = String(val)
    end
  end
end
