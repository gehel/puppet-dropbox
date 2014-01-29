require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'dropbox' do

  let(:title) { 'dropbox' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' } }

  describe 'Test minimal installation' do
    it { should contain_package('dropbox').with_ensure('present') }
    it { should contain_file('dropbox.conf').with_ensure('present') }
  end

  describe 'Test installation of a specific version' do
    let(:params) { {:version => '1.0.42' } }
    it { should contain_package('dropbox').with_ensure('1.0.42') }
  end

  describe 'Test decommissioning - absent' do
    let(:params) { {:absent => true } }
    it 'should remove Package[dropbox]' do should contain_package('dropbox').with_ensure('absent') end 
    it 'should remove dropbox configuration file' do should contain_file('dropbox.conf').with_ensure('absent') end
  end

  describe 'Test noops mode' do
    let(:params) { {:noops => true} }
    it { should contain_package('dropbox').with_noop('true') }
    it { should contain_file('dropbox.conf').with_noop('true') }
  end

  describe 'Test customizations - template' do
    let(:params) { {:template => "dropbox/spec.erb" , :options => { 'opt_a' => 'value_a' } } }
    it 'should generate a valid template' do
      content = catalogue.resource('file', 'dropbox.conf').send(:parameters)[:content]
      content.should match "fqdn: rspec.example42.com"
    end
    it 'should generate a template that uses custom options' do
      content = catalogue.resource('file', 'dropbox.conf').send(:parameters)[:content]
      content.should match "value_a"
    end
  end

  describe 'Test customizations - source' do
    let(:params) { {:source => "puppet:///modules/dropbox/spec"} }
    it { should contain_file('dropbox.conf').with_source('puppet:///modules/dropbox/spec') }
  end

  describe 'Test customizations - source_dir' do
    let(:params) { {:source_dir => "puppet:///modules/dropbox/dir/spec" , :source_dir_purge => true } }
    it { should contain_file('dropbox.dir').with_source('puppet:///modules/dropbox/dir/spec') }
    it { should contain_file('dropbox.dir').with_purge('true') }
    it { should contain_file('dropbox.dir').with_force('true') }
  end

  describe 'Test customizations - custom class' do
    let(:params) { {:my_class => "dropbox::spec" } }
    it { should contain_file('dropbox.conf').with_content(/rspec.example42.com/) }
  end

end
