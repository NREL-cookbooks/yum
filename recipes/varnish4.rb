#
# Cookbook Name:: yum
# Recipe:: varnish
#
# Copyright 2014, NREL
#
# All rights reserved - Do Not Redistribute
#

yum_repository "varnish" do
  description "Varnish 4.0 for Enterprise Linux el6 - $basearch"
  url node['yum']['varnish4']['url']
  action :create
end
