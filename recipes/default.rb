#
# Cookbook Name:: training-cookbook
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
node['training_cookbook']['packages'].each do |packagename|
  log "installing #{packagename}"
  package packagename do
    action :install
  end
end

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
