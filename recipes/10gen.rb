#
# Cookbook Name:: yum
# Recipe:: 10gen
#
# Copyright 2010, NREL
#
# All rights reserved - Do Not Redistribute
#

if platform?("redhat", "centos", "fedora")
  arch = if(node[:kernel][:machine] =~ /x86_64/) then "x86_64" else "i686" end
  yum_repository "10gen" do
    action :add
    description "10gen Repository"
    url "http://downloads-distro.mongodb.org/repo/redhat/os/#{arch}"
  end
end
