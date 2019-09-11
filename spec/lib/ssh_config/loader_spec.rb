# frozen_string_literal: true

require 'ssh_config/loader'

RSpec.describe SshConfig::Loader do
  subject(:loader) { described_class.new }

  describe '#parse' do
    context 'with a simple example' do
      subject(:data) { loader.parse(ssh_config) }
      let(:ssh_config) do
        <<-SSH_CONFIG
        Host chihuahua
        HostName chihuahua.example.com
        User oscar
        Port 123

        Host beagle
        User butch

        Host jrt jack-russell-terrier jack-russell-terrier.example.com 127.0.0.2
        HostName jack-russell-terrier.example.com
        User sally

        Host great-dane mutt bulldog
        HostName %h.example.com
        User joecool

        Host *.example.com
        ForwardAgent true

        Host *
        ForwardAgent false
        SSH_CONFIG
      end

      it 'only has expected keys' do
        expect(data.keys).to contain_exactly(
          'chihuahua',
          'beagle',
          'jrt',
          'jack-russell-terrier',
          'great-dane',
          'mutt',
          'bulldog'
        )
      end
    end
  end
end
