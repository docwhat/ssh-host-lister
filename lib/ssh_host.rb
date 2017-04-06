# frozen_string_literal: true

# SshHost represents a single Host entry in an ssh_config(5)
class SshHost
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
end
