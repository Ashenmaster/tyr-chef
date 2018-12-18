#
# Cookbook:: docker-setup
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

docker_service 'default' do
  action [:create, :start]
end

package 'docker-compose'

cookbook_file '/tmp/docker-compose.yml' do
  source 'docker-compose.yml'
  if node[:name] != 'main'
    owner 'root'
  else
    owner 'cgray'
  end
  group 'docker'
  action :create
end

execute 'docker up' do
  command 'COMPOSE_HTTP_TIMEOUT=200 docker-compose -f /tmp/docker-compose.yml up -d'
  if node[:name] != 'main'
    user 'root'
  else
    user 'cgray'
  end
end