#
# Cookbook Name:: training-cookbook
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node['training_cookbook']['users'].each do |username|
  home_dir = "/home/#{username}"
  log "creating user #{username}"
  user username do
    shell '/usr/bin/zsh'
    home home_dir
  end
  log "creating user #{home_dir}"
  directory home_dir do
    owner username.to_s
    group username.to_s
    mode '0755'
    action :create
  end
  log "copying zshrc to user #{username}"
  cookbook_file "#{home_dir}/.zshrc" do
    source 'zshrc'
    owner username.to_s
    group username.to_s
    mode '0644'
    action :create
  end
end
cookbook_file '/usr/local/bin/consul' do
  source 'consul'
  mode '0755'
  not_if { ::File.exist?('/usr/local/bin/consul') }
end

consul_user = 'consul'
%w( data config ).each do |dir|
  log "creating directory /opt/consul/#{dir}"
  directory "/opt/consul/#{dir}" do
    owner consul_user
    group consul_user
    mode '00755'
    recursive true
    action :create
  end
end

log 'Setting up consul as a supervisord service'
command = '/usr/local/bin/consul agent -data-dir /opt/consul/data -datacenter dc -config-dir /opt/consul/config'
supervisor_service 'consul' do
  action :enable
  autostart true
  user consul_user
  command command
end
