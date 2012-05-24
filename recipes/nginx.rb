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
end

yum_package(package_name) do
  source "#{Chef::Config[:file_cache_path]}/#{rpm}"
  flush_cache [:after]
  only_if {::File.exists?("#{Chef::Config[:file_cache_path]}/#{rpm}")}
  # FIXME: Issue with chef 0.10.10: http://tickets.opscode.com/browse/CHEF-3135
  #action :nothing
end

file "#{package_name}-cleanup" do
  path "#{Chef::Config[:file_cache_path]}/#{rpm}"
  action :delete
end
