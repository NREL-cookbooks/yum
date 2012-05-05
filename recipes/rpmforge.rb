#
# Cookbook Name:: yum
# Recipe:: rpmforge
#
# Copyright 2012, NREL
#
# All rights reserved - Do Not Redistribute
#

package_name = "rpmforge-release"
major = node['platform_version'].to_i
rpmforge = node['yum']['rpmforge_release']
arch = node[:kernel][:machine]
rpm = "#{package_name}-#{rpmforge}.el#{major}.rf.#{arch}.rpm"

remote_file "#{Chef::Config[:file_cache_path]}/#{rpm}" do
  source "http://pkgs.repoforge.org/rpmforge-release/#{rpm}"
  not_if "rpm -qa | grep -q '^#{package_name}-#{rpmforge}'"
end

yum_package package_name do
  source "#{Chef::Config[:file_cache_path]}/#{rpm}"
  flush_cache [:after]
  only_if {::File.exists?("#{Chef::Config[:file_cache_path]}/#{rpm}")}
  action :nothing
end

file "#{package_name}-cleanup" do
  path "#{Chef::Config[:file_cache_path]}/#{rpm}"
  action :delete
end
