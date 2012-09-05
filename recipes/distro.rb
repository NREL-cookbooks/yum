#
# Cookbook Name:: yum
# Recipe:: distro
#
# Copyright 2012, NREL
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
when "redhat"
  template "/etc/yum/pluginconf.d/rhnplugin.conf" do
    source "rhnplugin.conf.erb"
  end
end
