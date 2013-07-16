#
# Cookbook Name:: yum
# Recipe:: pgdg
#
# Copyright 2012, NREL
#
# All rights reserved - Do Not Redistribute
#

node.set[:yum][:exclude] = (node[:yum][:exclude] + ["postgresql*"]).uniq
include_recipe "yum::distro"

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
