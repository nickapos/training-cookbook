#
# Cookbook Name:: training-cookbook
# Recipe:: install_packages
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
