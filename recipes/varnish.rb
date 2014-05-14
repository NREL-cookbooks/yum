#
# Cookbook Name:: yum
# Recipe:: varnish
#
# Copyright 2012, NREL
#
# All rights reserved - Do Not Redistribute
#

yum_repository "varnish" do
  description "Varnish 3.0 for Enterprise Linux el6 - $basearch"
  url node['yum']['varnish']['url']
  action :create
end
