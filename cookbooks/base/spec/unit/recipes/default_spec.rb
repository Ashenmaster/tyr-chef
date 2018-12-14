#
# Cookbook:: base
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'base::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should install cron' do
      expect(chef_run).to install_package('cron')
    end

    it 'should enable cron' do
      expect(chef_run).to enable_service('cron')
    end

    it 'should start cron' do
      expect(chef_run).to enable_service('cron')
    end

    it 'should create a cron' do
      expect(chef_run).to create_cron('chef-pull').with(time: :hourly)
    end

    it 'should install lm-sensors' do
      expect(chef_run).to install_package 'lm-sensors'
    end

    it 'should remove apache' do
      expect(chef_run).to remove_package 'apache2'
    end

    it 'should create a docker user' do
      expect(chef_run).to create_user 'docker'
    end

    it 'should create a chris user' do
      expect(chef_run).to create_user 'chris'
    end

    it 'should create a docker group' do
      expect(chef_run).to create_group 'docker'
    end

    it 'should mount UserData' do
      expect(chef_run).to mount_mount('/media/UserData/')
    end

    it 'should enable UserData' do
      expect(chef_run).to enable_mount('/media/UserData/')
    end
  end
end
