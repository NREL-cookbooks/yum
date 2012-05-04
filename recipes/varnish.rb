#
# Cookbook Name:: yum
# Recipe:: varnish
#
# Copyright 2012, NREL
#
# All rights reserved - Do Not Redistribute
#

rpm_name = "varnish-release"
rpm = "#{rpm_name}-3.0-1.noarch.rpm"

remote_file "#{Chef::Config[:file_cache_path]}/#{rpm}" do
  source "http://repo.varnish-cache.org/redhat/varnish-3.0/el5/noarch/#{rpm}"
  not_if "rpm -qa | grep -qx '#{rpm_name}'"
end

# Internal cache needs to be reloaded, so the new packages are found:
# http://tickets.opscode.com/browse/COOK-1227
ruby_block "reload-internal-yum-cache" do
  block do
    Chef::Provider::Package::Yum::YumCache.instance.reload
  end
  action :nothing
end

rpm_package(rpm_name) do
  source "#{Chef::Config[:file_cache_path]}/#{rpm}"
  notifies :create, "ruby_block[reload-internal-yum-cache]", :immediately
end
