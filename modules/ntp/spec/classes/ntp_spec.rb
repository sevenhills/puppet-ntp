require 'spec_helper'

describe 'ntp' do

  let(:title) { 'ntp' }
  let(:node) { 'centos65' }
  let :facts do
    {
      :id                        => 'root',
      :osfamily                  => 'Debian',
      :kernel                    => 'Linux',
      :operatingsystem           => 'Debian',
      :path                      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    }
  end

  describe 'Test standard installation' do
    it { should contain_package('ntp').with_ensure('latest') }
    it { should contain_package('ntp').with_name('ntp') }
    it { should contain_service('ntp').with_ensure('running') }
    it { should contain_service('ntp').with_enable('true') }
    it { should contain_file('ntp.conf').with_ensure('file') }
    it 'should generate a valid default template' do
      should contain_file('ntp.conf').with_content(/server 0.rhel.pool.ntp.org/)
    end
  end
end

