#
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Cookbook Name:: yum
# Recipe:: ius
#
# Copyright:: Copyright (c) 2011 Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "yum::epel"

package "epel-release"

major = node['platform_version'].to_i
ius   = node['yum']['ius_release']

remote_file "#{Chef::Config[:file_cache_path]}/ius-release.rpm" do
  source "https://rhel#{major}.iuscommunity.org/ius-release.rpm"
  not_if "rpm -qa | grep -q '^ius-release'"
  notifies :install, "rpm_package[ius-release]", :immediately
end

rpm_package "ius-release" do
  source "#{Chef::Config[:file_cache_path]}/ius-release.rpm"
  only_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/ius-release.rpm") }
  action :nothing
end

file "ius-release-cleanup" do
  path "#{Chef::Config[:file_cache_path]}/ius-release.rpm"
  action :delete
end
