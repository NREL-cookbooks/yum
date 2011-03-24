#
# Cookbook Name:: yum
# Recipe:: epel
#
# Copyright 2010, NREL
#
# All rights reserved - Do Not Redistribute
#

if platform?("redhat", "centos", "fedora")
  remote_file "/tmp/epel-release-6-5.noarch.rpm" do
    source "http://download.fedora.redhat.com/pub/epel/beta/6/i386/epel-release-6-5.noarch.rpm"
    checksum "28aacc55514d080d0813b1598c4a6a708b064bef0a373aacb60eaa16998d157b"
  end

  package "epel-release" do
    source "/tmp/epel-release-6-5.noarch.rpm"
    options "--nogpgcheck" 
  end
end
