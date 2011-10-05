require 'spec_helper'

describe Repository::Github do
  let(:git)    { stub('git') }
  let(:github) { Repository::Github.new(git, 'travis-ci/travis-ci') }

  it 'fetch fetches the given commit from the scm' do
    git.expects(:fetch).with('git://github.com/travis-ci/travis-ci.git', '1234567', 'travis-ci/travis-ci')
    github.fetch('1234567')
  end

  it 'config_url returns the github specific config url for the given commit' do
    github.config_url('1234567').should == 'http://raw.github.com/travis-ci/travis-ci/1234567/.travis.yml'
  end

  it 'source_url returns the github specific source url' do
    github.source_url.should == 'git://github.com/travis-ci/travis-ci.git'
  end
end
