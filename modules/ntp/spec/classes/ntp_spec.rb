require 'spec_helper'

describe 'ntp' do

  let(:title) { 'ntp' }
  let(:node) { 'precise32' }
  let :facts do
    {
      :ipaddress                 => '10.42.42.42',
      :id                        => 'root',
      :osfamily                  => 'Debian',
      :kernel                    => 'Linux',
      :operatingsystem           => 'ubuntu',
      #:operatingsystemrelease    => '7.8',
      #:operatingsystemmajrelease => '7',
      #:virtual                   => 'physical',
      :path                      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      #:concat_basedir            => '/dne',
    }
  end

  describe 'Test standard installation' do
    it { should contain_package('ntp').with_ensure('latest') }
    it { should contain_package('ntp').with_name('ntp') }
    it { should contain_service('ntp').with_ensure('running') }
    it { should contain_service('ntp').with_enable('true') }
    it { should contain_file('ntp.conf').with_ensure('file') }
    it 'should generate a valid default template' do
      should contain_file('ntp.conf').with_content(/server 1.pool.ntp.org/)
    end
  end

  describe 'Test installation of a specific version' do
    let(:params) { {:version => '1.0.42' } }
    it { should contain_package('ntp').with_ensure('1.0.42') }
  end

  describe 'Test decommissioning - absent' do
    let(:params) { {:absent => true } }

    it 'should remove Package[ntp]' do should contain_package('ntp').with_ensure('absent') end 
    it 'should not manage Service[ntp]' do should_not contain_service('ntpd') end
    it 'should remove ntp configuration file' do should contain_file('ntp.conf').with_ensure('absent') end
  end

  describe 'Test service autorestart' do
    it { should contain_file('ntp.conf').with_notify('Service[ntp]') }
  end

end

