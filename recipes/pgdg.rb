#
# Cookbook Name:: yum
# Recipe:: pgdg
#
# Copyright 2012, NREL
#
# All rights reserved - Do Not Redistribute
#

node.set[:yum][:exclude] = node[:yum][:exclude] + ["postgresql*"]
include_recipe "yum::yum"

major = node[:platform_version].to_i

root_distro = node[:platform]
root_distro_short = node[:platform]
if platform?("redhat", "centos", "scientific", "fedora")
  root_distro_short = "rhel"
end

distro = node[:platform]
if platform?("scientific")
  distro = "sl"
end

version = node[:postgresql][:version]
version_no_dot = version.gsub(/\./, "")
node.set[:postgresql][:version_no_dot] = version_no_dot

package_name = "pgdg-#{distro}#{version_no_dot}"
rpm_name = "#{package_name}-#{version}-#{node[:yum][:pgdg_release]}.noarch"
rpm = "#{rpm_name}.rpm"

remote_file "#{Chef::Config[:file_cache_path]}/#{rpm}" do
  source "http://yum.postgresql.org/#{version}/#{root_distro}/#{root_distro_short}-#{major}-#{node[:kernel][:machine]}/#{rpm}"
  not_if "rpm -qa | grep -q '^#{package_name}-#{version}'"
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
