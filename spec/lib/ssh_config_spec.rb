# frozen_string_literal: true
require 'ssh_config'

RSpec.describe SshConfig do
  subject(:ssh_config) { described_class }

  describe 'load_defaults' do
    subject(:result) { described_class.load_defaults }

    it { is_expected.to be_a Hash }
  end
end
