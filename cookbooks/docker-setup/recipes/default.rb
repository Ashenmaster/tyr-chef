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

# Copy telegraf config
template "#{configs['environment']['userDir']}telegraf.conf" do
  source "user_dir_telegraf.conf.erb"
end

# Upload openVPN config files
cookbook_file "#{configs['environment']['userDir']}docker/openvpn/config/etc/as.conf" do
  source 'as.conf'
end

cookbook_file "#{configs['environment']['userDir']}docker/openvpn/config/etc/config.json" do
  source 'config.json'
end

# Copy Nginx root config file

template '/opt/appdata/letsencrypt/config/nginx/site-confs/default' do
  source "opt_appdata_letsencrypt_config_nginx_site-confs_default.conf.erb"
  variables composeConfigs: {
      "configs" => configs
  }
end

configs['letsencrypt'].each {|domain, settings|
  template "/opt/appdata/letsencrypt/config/nginx/site-confs/#{domain}" do
      source "opt_appdata_letsencrypt_config_nginx_site-confs_template.conf.erb"
      variables nginxConfigs: {
          "domain" => domain,
          "settings" => settings
      }
  end
}

cookbook_file '/opt/appdata/letsencrypt/config/nginx/proxy.conf' do
  source "proxy.conf"
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
      'remote' => 'remote',
      'chef' => 'chef'
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

