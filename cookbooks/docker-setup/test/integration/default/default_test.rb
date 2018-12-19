# # encoding: utf-8

# Inspec test for recipe docker-setup::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe file('/tmp/docker-compose.yml') do
  it { should exist }
end

describe docker.version do
  its('Server.Version') { should cmp >= '1.12'}
  its('Client.Version') { should cmp >= '1.12'}
end

describe docker_container('letsencrypt-proxy') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/letsencrypt:185' }
end

describe docker_container('letsencrypt-proxy') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/letsencrypt:185' }
end

describe docker_container('portainer') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'portainer/portainer:develop' }
end

describe docker_container('qbittorrent') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/qbittorrent:105' }
end

describe docker_container('nzbget') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/nzbget:149' }
end

describe docker_container('radarr') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/radarr:140' }
end

describe docker_container('sonarr') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/sonarr:164' }
end

describe docker_container('lidarr') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/lidarr:188' }
end

describe docker_container('mylar') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/mylar:158' }
end

describe docker_container('ubooquity') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/ubooquity:122' }
end

describe docker_container('plexms') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'plexinc/pms-docker:plexpass' }
end

describe docker_container('tautulli') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/tautulli:154' }
end

describe docker_container('tautulli') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/tautulli:154' }
end

describe docker_container('ombi') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/ombi:130' }
end

describe docker_container('hydra2') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/hydra2:115' }
end

describe docker_container('jackett') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/jackett:329' }
end

describe docker_container('watchtower') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'v2tec/watchtower' }
end

describe docker_container('influxdb') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'influxdb:1.7' }
end

describe docker_container('grafana') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'grafana/grafana:5.3.4' }
end

describe docker_container('telegraf') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'telegraf:1.8' }
end

describe docker_container('openVPN') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'linuxserver/openvpn-as:152' }
end

describe file('/etc/ddclient.conf') do
  it { should exist }
end
