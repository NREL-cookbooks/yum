#
# Cookbook Name:: yum
# Recipe:: 10gen
#
# Copyright 2010, NREL
#
# All rights reserved - Do Not Redistribute
#

if platform?("redhat", "centos", "fedora")
  yum_repository "10gen" do
    description "10gen Repository"
    url "http://downloads-distro.mongodb.org/repo/redhat/os/$basearch"
  end
end
