# frozen_string_literal: true
require 'ssh_config/entry'

RSpec.describe SshConfig::Entry do
  subject(:host) { described_class.new names }
  let(:names) do
    %w(
      jrt
      jack-russell-terrier
      jack-russell-terrier.example.com
      127.1.1.23
    )
  end

  it 'exists' do
    host
  end

  describe '#distinct_names' do
    subject(:distinct_names) { host.distinct_names }

    it { is_expected.to have_attributes(count: 2) }
    it { is_expected.to_not include 'jack-russell-terrier.example.com' }
    it { is_expected.to_not include '127.1.1.23' }
    it { is_expected.to include 'jack-russell-terrier' }
    it { is_expected.to include 'jrt' }
  end

  describe '#user' do
    it { is_expected.to have_attributes(user: nil) }

    context 'when assigned the value "foo"' do
      before { host.user = 'foo' }
      it { is_expected.to have_attributes(user: 'foo') }
    end
  end
end
