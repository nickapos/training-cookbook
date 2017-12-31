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
  log "creating user #{username}"
  user username do
    shell '/usr/bin/zsh'
  end
end
