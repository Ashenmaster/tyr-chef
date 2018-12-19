#
# Cookbook:: docker-setup
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

configs = data_bag_item('docker-config', 'configs')

docker_service 'default' do
  action [:create, :start]
end

package 'docker-compose'

template '/tmp/docker-compose.yml' do
  source 'tmp_docker_compose.yml.erb'
  if node[:name] != 'main'
    owner 'root'
  else
    owner 'cgray'
  end
  group 'docker'
  variables composeConfigs: {
      "configs" => configs
  }
end


execute 'docker up' do
  command 'COMPOSE_HTTP_TIMEOUT=200 docker-compose -f /tmp/docker-compose.yml up -d'
  if node[:name] != 'main'
    user 'root'
  else
    user 'cgray'
  end
end

package 'ddclient'

template '/etc/ddclient.conf' do
  source 'etc_ddclient.conf.erb'
  owner 'root'
  group 'root'
  mode '0600'
  variables domains: {
      'base' => '@',
      'vpn' => 'vpn',
      'remote' => 'remote'
  }
end