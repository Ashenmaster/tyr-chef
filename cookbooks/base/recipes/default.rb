#
# Cookbook:: base
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
package('cron')

service 'cron' do
  action [:enable, :start]
end

cron 'chef-pull' do
  time :hourly
  command 'chef-client'
end

# Install lm-sensors
package 'lm-sensors'

package 'apache2' do
  action [:remove]
end

user 'cgray' do
  comment "A user to run docker-setup with"
  shell "/bin/bash"
  password"$1$9thzRKyt$SjqvBAvzxRPkPPCbJW0VD0"
end

user 'chris' do
  comment "A main user"
  shell "/bin/zsh"
  gid "sudo"
  password"$1$9thzRKyt$SjqvBAvzxRPkPPCbJW0VD0"
end

group 'docker' do
  append true
  members ['cgray', 'chris']
end

if node[:chef_environment] != 'production' || File.read('/etc/mtab').lines.grep('/media/UserData')
else
  mount '/media/UserData/' do
    device '/dev/pandora-vg/media'
    fstype 'ext4'
    action [:mount, :enable]
  end
end

package('nfs-kernel-server')

cookbook_file '/etc/exports' do
  source "etc_exports"
end

service 'nfs-kernel-server' do
  action [:enable, :start]
end