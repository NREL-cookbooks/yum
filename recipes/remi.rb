#
# Cookbook Name:: yum
# Recipe:: remi
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#

if platform?("redhat", "centos", "fedora")
  # Manually install the REMI yum repo, rather than using the RPM installation
  # REMI provides. This is because the RPM installs the repos disabled by
  # default, and che chef yum stuff doesn't have a simple way to enable a
  # disabled repo.
  yum_key "RPM-GPG-KEY-remi" do
    action :add
    url "http://rpms.famillecollet.com/RPM-GPG-KEY-remi"
  end

  yum_repository "remi" do
    action :add
    description "Les RPM de remi pour Enterprise Linux $releasever - $basearch"
    url "http://rpms.famillecollet.com/enterprise/$releasever/remi/mirror"
    mirrorlist true
    key "RPM-GPG-KEY-remi"
    enabled "1"
    failovermethod "priority"
  end

  yum_repository "remi-test" do
    action :add
    description "Les RPM de remi en test pour Enterprise Linux $releasever - $basearch"
    url "http://rpms.famillecollet.com/enterprise/$releasever/test/mirror"
    mirrorlist true
    key "RPM-GPG-KEY-remi"
    enabled "0"
  end
end
