#
# Cookbook Name:: yum
# Recipe:: varnish
#
# Copyright 2012, NREL
#
# All rights reserved - Do Not Redistribute
#

package_name = "varnish-release"
varnish = node[:yum][:varnish_release]
rpm = "#{package_name}-#{varnish}.noarch.rpm"

remote_file "#{Chef::Config[:file_cache_path]}/#{rpm}" do
  source "http://repo.varnish-cache.org/redhat/varnish-3.0/el5/noarch/#{rpm}"
  not_if "rpm -qa | grep -q '^#{package_name}-#{varnish}'"
end

yum_package package_name do
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
