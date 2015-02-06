#!/bin/bash
#wget https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb
#dpkg -i puppetlabs-release-wheezy.deb
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
apt-get update
apt-get install puppet facter augeas-tools -y
