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