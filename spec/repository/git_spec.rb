require 'spec_helper'

describe Scm::Git do
  let(:shell)  { stub('shell', :export => nil, :execute => true, :chdir => true) }
  let(:scm)    { Scm::Git.new(shell) }

  let(:source) { 'git://example.com/travis-ci.git' }
  let(:commit) { '1234567' }
  let(:target) { 'travis-ci' }

  describe 'fetch' do
    it 'makes sure interactive auth does not hang' do
      shell.expects(:export).with('GIT_ASKPASS', 'echo', :echo => false)
      scm.fetch(source, commit, target)
    end

    it 'clones the repository' do
      shell.expects(:execute).with('git clone --depth=100 --quiet git://example.com/travis-ci.git travis-ci')
      scm.fetch(source, commit, target)
    end

    it 'changes to the repository working directory' do
      shell.expects(:chdir).with('travis-ci')
      scm.fetch(source, commit, target)
    end

    it 'checks the given commit out' do
      shell.expects(:execute).with('git checkout -qf 1234567')
      scm.fetch(source, commit, target)
    end
  end
end
