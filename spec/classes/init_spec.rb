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
          'source' => nil,
          'owner'  => 'root',
          'group'  => 'root',
          'mode'   => '0644',
        })
      }

      it { should contain_file('root_bashrc').without_content(/^umask/) }
    end
  end

  describe 'with root_bashrc_source specified' do
    let(:params) { { :root_bashrc_source => 'source/file' } }

    it {
      should contain_file('root_bashrc').with({
        'ensure'  => 'file',
        'path'    => '/.bashrc',
        'source'  => 'puppet:///modules/source/file',
        'content' => nil,
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      })
    }
  end

  describe 'with root_bashrc_mode specified' do
    context 'as a valid mode' do
      let(:params) { { :root_bashrc_mode => '0600' } }

      it {
        should contain_file('root_bashrc').with({
          'ensure'  => 'file',
          'path'    => '/.bashrc',
          'source'  => nil,
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0600',
        })
      }
    end

    [true,'666','66666'].each do |mode|
      context "as invalid mode #{mode}" do
        let(:params) { { :root_bashrc_mode => mode } }

        it 'should fail' do
          expect {
            should contain_class('redhat')
          }.to raise_error(Puppet::Error,/^redhat::root_bashrc_mode is <#{mode}> and must be a valid four digit mode in octal notation./)
        end
      end
    end
  end

  describe 'with umask parameter specified' do
    context 'as a valid umask' do
      let(:params) { { :umask => '0022' } }

      it { should contain_file('root_bashrc').with_content(/^umask 0022$/) }
    end

    [true,'666','00222'].each do |umask|
      context "as invalid umask #{umask}" do
        let(:params) { { :umask => umask } }

        it 'should fail' do
          expect {
            should contain_class('redhat')
          }.to raise_error(Puppet::Error,/^redhat::umask is <#{umask}> and must be a valid four digit mode in octal notation./)
        end
      end
    end
  end
end
