#
# Cookbook Name:: yum
# Recipe:: cron
#
# Copyright 2013, NREL
#
# All rights reserved - Do Not Redistribute
#

package "yum-cron"

template "/etc/sysconfig/yum-cron" do
  source "cron_sysconfig.erb"
  owner "root"
  group "root"
  mode "0644"
end

service "yum-cron" do
  supports :status => true, :restart => true
  action [:enable, :start]
end
