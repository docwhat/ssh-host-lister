# frozen_string_literal: true
require 'ssh_config'

RSpec.describe SshConfig do
  subject(:ssh_config) { described_class.new }

  describe '#parse' do
    it 'parses empty strings' do
      ssh_config.parse('')
    end

    context 'with a simple config' do
      let(:config) do
        <<-EOF
        Host chihuahua
        HostName chihuahua.dog.example.com
        User oscar
        Port 123

        Host beagle
        User butch

        Host jrt jack-russel-terrier
        HostName jack-russell-terrier.dog.example.com
        User sally
        EOF
      end

      it 'parses' do
        ssh_config.parse(config)
      end

      it 'has 4 hosts' do
        expect(ssh_config.count).to eq(4)
      end
    end
  end
end
