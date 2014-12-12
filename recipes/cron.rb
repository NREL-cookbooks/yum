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

template "/etc/yum/yum-daily.yum" do
  source "cron_yum_daily.erb"
  owner "root"
  group "root"
  mode "0644"
end

# Make sure the cron job is executable, since we had disabled it on some
# systems by making it non-executable. Going forward, we should instead disable
# this as needed by disabling the "yum-cron" service via the
# node[:yum][:cron][:disable] attribute.
file "/etc/cron.daily/0yum.cron" do
  mode "0755"
end

service "yum-cron" do
  supports :status => true, :restart => true
  if(node[:yum][:cron][:disable])
    action [:stop, :disable]
  else
    action [:enable, :start]
  end
end
