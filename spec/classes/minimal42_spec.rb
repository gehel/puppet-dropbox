require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'puppet-dropbox' do

  let(:title) { 'puppet-dropbox' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' } }

  describe 'Test minimal installation' do
    it { should contain_package('puppet-dropbox').with_ensure('present') }
    it { should contain_file('puppet-dropbox.conf').with_ensure('present') }
  end

  describe 'Test installation of a specific version' do
    let(:params) { {:version => '1.0.42' } }
    it { should contain_package('puppet-dropbox').with_ensure('1.0.42') }
  end

  describe 'Test decommissioning - absent' do
    let(:params) { {:absent => true } }
    it 'should remove Package[puppet-dropbox]' do should contain_package('puppet-dropbox').with_ensure('absent') end 
    it 'should remove puppet-dropbox configuration file' do should contain_file('puppet-dropbox.conf').with_ensure('absent') end
  end

  describe 'Test noops mode' do
    let(:params) { {:noops => true} }
    it { should contain_package('puppet-dropbox').with_noop('true') }
    it { should contain_file('puppet-dropbox.conf').with_noop('true') }
  end

  describe 'Test customizations - template' do
    let(:params) { {:template => "puppet-dropbox/spec.erb" , :options => { 'opt_a' => 'value_a' } } }
    it 'should generate a valid template' do
      content = catalogue.resource('file', 'puppet-dropbox.conf').send(:parameters)[:content]
      content.should match "fqdn: rspec.example42.com"
    end
    it 'should generate a template that uses custom options' do
      content = catalogue.resource('file', 'puppet-dropbox.conf').send(:parameters)[:content]
      content.should match "value_a"
    end
  end

  describe 'Test customizations - source' do
    let(:params) { {:source => "puppet:///modules/puppet-dropbox/spec"} }
    it { should contain_file('puppet-dropbox.conf').with_source('puppet:///modules/puppet-dropbox/spec') }
  end

  describe 'Test customizations - source_dir' do
    let(:params) { {:source_dir => "puppet:///modules/puppet-dropbox/dir/spec" , :source_dir_purge => true } }
    it { should contain_file('puppet-dropbox.dir').with_source('puppet:///modules/puppet-dropbox/dir/spec') }
    it { should contain_file('puppet-dropbox.dir').with_purge('true') }
    it { should contain_file('puppet-dropbox.dir').with_force('true') }
  end

  describe 'Test customizations - custom class' do
    let(:params) { {:my_class => "puppet-dropbox::spec" } }
    it { should contain_file('puppet-dropbox.conf').with_content(/rspec.example42.com/) }
  end

end
