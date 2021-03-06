#
# Cookbook Name:: yum
# Attributes:: default
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

# Example: override.yum.exclude = "kernel* compat-glibc*"
default['yum']['exclude'] = Array.new
default['yum']['installonlypkgs'] = Array.new
default['yum']['ius_release'] = '1.0-13'
default['yum']['repoforge_release'] = '0.5.3-1'
default['yum']['proxy'] = ''
default['yum']['proxy_username'] = ''
default['yum']['proxy_password'] = ''
default['yum']['cachedir'] = '/var/cache/yum'
default['yum']['keepcache'] = 0

default[:yum][:distro][:exclude] = Array.new

default[:yum][:pgdg_release] =  case node[:platform_version].to_i
                                  when 6 
                                    case node[:platform]
                                    when "redhat"
                                      5
                                    when "centos"
                                      4
                                    when "scientific"
                                      6
                                    end
                                  end

default[:yum][:varnish_release] = "3.0-1"
