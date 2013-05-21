require 'spec_helper'

  describe 'redhat' do

    describe 'should include redhat class with default params' do

      let :facts do
        {
          :osfamily          => 'redhat',
          :lsbmajdistrelease => '6',
        }
      end

      it { should include_class('redhat') }
    end
  end
