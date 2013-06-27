require 'spec_helper'

describe 'redhat' do

  describe 'should contain class puppet' do
    it { should include_class('redhat') }
  end

  describe 'should contain package' do
    it {
      should contain_package('redhat-lsb').with({
        'ensure' => 'present',
      })
    }
  end

  describe 'should contain file with default parameters' do
    it {
      should contain_file('root_bashrc').with({
        'ensure' => 'file',
        'path'   => '/.bashrc',
        'source' => 'puppet:///modules/redhat/root_bashrc',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
    }
  end

  describe 'should contain file with one parameter for root_bashrc_source' do
    let :params do
      {
        :root_bashrc_source => 'source/file'
      }
    end
    it {
      should contain_file('root_bashrc').with({
        'ensure' => 'file',
        'path'   => '/.bashrc',
        'source' => 'puppet:///modules/source/file',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
    }
  end

  describe 'should contain service and file for EL6' do
    let :facts do
      {
        :osfamily          => 'redhat',
        :lsbmajdistrelease => '6',
      }
    end
    it {
      should contain_file('ttys1_conf').with({
        'ensure' => 'file',
        'path'   => '/etc/init/ttyS1.conf',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
    }
    it {
      should contain_service('ttyS1').with({
        'ensure'     => 'running',
        'hasstatus'  => 'false',
        'hasrestart' => 'false',
        'start'      => '/sbin/initctl start ttyS1',
        'stop'       => '/sbin/initctl stop ttyS1',
        'status'     => '/sbin/initctl status ttyS1 | grep ^"ttyS1 start/running" 1>/dev/null 2>&1',
        'require'    => 'File[ttys1_conf]',
      })
    }
  end
end
