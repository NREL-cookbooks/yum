#
# Cookbook Name:: yum
# Recipe:: opsview
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#

if platform?("redhat", "centos", "fedora")
  yum_repository "opsview" do
    action :add
    description "Opsview"
    url "http://downloads.opsview.com/opsview-core/latest/yum/rhel/$releasever/$basearch"
    enabled "1"
  end
end
