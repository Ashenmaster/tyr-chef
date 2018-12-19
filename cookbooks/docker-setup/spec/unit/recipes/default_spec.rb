#
# Cookbook:: docker-setup
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'docker-setup::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '18.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should install docker-compose' do
      expect(chef_run).to install_package('docker-compose')
    end

    it 'should create the docker-compose file' do
      expect(chef_run).to create_cookbook_file('/tmp/docker-compose.yml')
    end

    it 'should run docker-compose up' do
      expect(chef_run).to run_execute('docker up')
    end

    it 'should install ddclient' do
      expect(chef_run).to install_package('ddclient')
    end

    it 'should create the ddclient.conf file from template' do
      expect(chef_run).to create_template('/etc/ddclient.conf').with(
          user:   'root',
          group:  'root',
          mode: '0600'
      )
    end

  end
end
