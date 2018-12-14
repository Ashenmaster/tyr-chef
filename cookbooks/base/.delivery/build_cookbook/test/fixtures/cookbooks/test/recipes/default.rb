# frozen_string_literal: true
%w(unit lint syntax).each do |phase|
  execute "HOME=/home/vagrant delivery job verify #{phase} --server localhost --ent test --org kitchen" do
    cwd '/tmp/repo-data'
    user 'vagrant'
    environment('GIT_DISCOVERY_ACROSS_FILESYSTEM' => '1')
  end
end
