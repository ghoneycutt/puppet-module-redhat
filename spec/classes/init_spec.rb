require 'spec_helper'
describe 'redhat' do
  let(:facts) { { :lsbmajdistrelease => '7' } }

  platforms = {
    'el5' =>
      { :osfamily          => 'RedHat',
        :lsbmajdistrelease => '5',
        :lsb_package       => 'redhat-lsb',
      },
    'el6' =>
      { :osfamily          => 'RedHat',
        :lsbmajdistrelease => '6',
        :lsb_package       => 'redhat-lsb',
      },
    'el7' =>
      { :osfamily          => 'RedHat',
        :lsbmajdistrelease => '7',
        :lsb_package       => 'redhat-lsb-core',
      },
  }

  describe 'with values for parameters left at their default values' do
    platforms.sort.each do |k,v|
      context "#{v[:osfamily]} #{v[:lsbmajdistrelease]}" do
        let :facts do
          { :osfamily          => v[:osfamily],
            :lsbmajdistrelease => v[:lsbmajdistrelease],
          }
        end


        it { should compile.with_all_deps }

        it { should contain_class('redhat') }

        it {
          should contain_package('redhat-lsb').with({
            'name'   => v[:lsb_package],
            'ensure' => 'present',
          })
        }

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

  describe 'with lsb_package specified' do
    context 'as a valid string' do
      let(:params) { { :lsb_package => 'my-redhat-lsb' } }

      it {
        should contain_package('redhat-lsb').with({
          'name'   => 'my-redhat-lsb',
          'ensure' => 'present',
        })
      }
    end

    [true,['an','array'],].each do |package_name|
      context "as an invalid type (non-string) #{package_name}" do
        let(:params) { { :lsb_package => package_name } }

        it 'should fail' do
          expect {
            should contain_class('redhat')
          }.to raise_error(Puppet::Error)
        end
      end
    end
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
