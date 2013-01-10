#
# Cookbook Name:: yumrepo
# Attributes:: ius
#
# Copyright 2011, Eric G. Wolfe
# Copyright 2011, Opscode, Inc.
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
#

version = node['platform_version'].to_i
case node['platform']
when "amazon"
  version = 6
end

default['yum']['ius']['url'] = "http://dmirr.iuscommunity.org/mirrorlist/?repo=ius-el#{version}&arch=$basearch"
default['yum']['ius']['key'] = "IUS-COMMUNITY-GPG-KEY"
default['yum']['ius']['key_url'] = "http://dl.iuscommunity.org/pub/ius/#{node['yum']['ius']['key']}"
