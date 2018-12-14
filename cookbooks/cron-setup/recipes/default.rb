#
# Cookbook:: cron-setup
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