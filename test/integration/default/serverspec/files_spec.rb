require 'spec_helper'

# Required by serverspec
set :backend, :exec

%w( user1 user2 user3 ).each do | username |
  describe file("/home/#{username}") do
    it { should be_directory }
  end
  describe file("/home/#{username}/.zshrc") do
    it { should be_file }
  end

  describe user(username) do
    it { should exist }
  end
end
