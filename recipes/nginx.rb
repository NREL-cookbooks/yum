#
# Cookbook Name:: yum
# Recipe:: nginx
#
# Copyright 2012, NREL
#
# All rights reserved - Do Not Redistribute
#

package_name = "nginx-release"
platform = node[:platform]
if(platform == "redhat")
  platform = "rhel"
end
major = node[:platform_version].to_i

rpm = "#{package_name}-#{platform}-#{major}-0.el#{major}.ngx.noarch.rpm"

remote_file "#{Chef::Config[:file_cache_path]}/#{rpm}" do
  source "http://nginx.org/packages/#{platform}/#{major}/noarch/RPMS/#{rpm}"
  not_if "rpm -qa | grep -q '^#{package_name}-#{platform}-#{major}'"
  notifies :install, "rpm_package[#{package_name}]", :immediately
end

rpm_package(package_name) do
  source "#{Chef::Config[:file_cache_path]}/#{rpm}"
  only_if {::File.exists?("#{Chef::Config[:file_cache_path]}/#{rpm}")}
  action :nothing
end

file "#{package_name}-cleanup" do
  path "#{Chef::Config[:file_cache_path]}/#{rpm}"
  action :delete
end
