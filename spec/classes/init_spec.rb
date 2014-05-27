require 'spec_helper'
describe 'redhat' do

  it { should compile.with_all_deps }

  describe 'should contain class puppet' do
    it { should contain_class('redhat') }
  end

  describe 'with default values for parameters' do
    context 'should contain package' do
      it {
        should contain_package('redhat-lsb').with({
          'ensure' => 'present',
        })
      }
    end

    context 'should contain .bashrc with default parameters' do
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
  end

  describe 'with root_bashrc_source specified' do
    let(:params) { { :root_bashrc_source => 'source/file' } }

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
end
