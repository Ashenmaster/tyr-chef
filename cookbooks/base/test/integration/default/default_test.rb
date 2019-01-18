# # encoding: utf-8

# Inspec test for recipe base::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe crontab('root') do
  its('commands') { should include 'chef-client' }
end

describe crontab('root').commands('chef-client') do
  its('hours') { should cmp '*' }
end

describe package('lm-sensors') do
  it { should be_installed }
end

describe package('apache2') do
  it { should_not be_installed }
end

describe user('docker') do
  it { should exist }
  its('group') { should eq 'docker' }
end

describe user('chris') do
  it { should exist }
  its('groups') { should eq ['sudo', 'docker']}
end

describe package('nfs-kernel-server') do
  it { should be_installed }
end