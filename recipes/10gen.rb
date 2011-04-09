#
# Cookbook Name:: yum
# Recipe:: 10gen
#
# Copyright 2010, NREL
#
# All rights reserved - Do Not Redistribute
#

if platform?("redhat", "centos", "fedora")
  template "/etc/yum.repos.d/10gen.repo" do
    source "10gen.repo.erb"
    owner "root"
    group "root"
    mode "0644"
  end
end
