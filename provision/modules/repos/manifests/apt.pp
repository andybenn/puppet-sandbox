# == Class: repos::apt
#
# This class installs the Puppet Labs APT repository.
#
# === Parameters
#
# === Actions
#
# - Install puppetlabs repository
# - Perform initial sync to update package database
#
# === Requires
#
# === Sample Usage
#
#   class { 'repos::apt': }
#
class repos::apt {

  exec { 'retrieve_puplabs_deb':
    command     => "/usr/bin/wget -q https://apt.puppetlabs.com/puppetlabs-release-'${lsbdistcodename}'.deb -O /tmp/puppetlabs-release-'${lsbdistcodename}'.deb",
    creates     => "/tmp/puppetlabs-release-'${lsbdistcodename}'.deb",
  }
 
  file{"/tmp/puppetlabs-release-'${lsbdistcodename}'.deb":
  mode => 0755,
  require => Exec["retrieve_puplabs_deb"],
  }

  exec { 'install_puppetlabs':
    path    => '/bin:/usr/bin:/sbin/:/usr/local/sbin:/usr/sbin:/sbin',
    onlyif  => "test -f /tmp/puppetlabs-release-'${lsbdistcodename}'.deb",
    command => "/usr/bin/dpkg -i /tmp/puppetlabs-release-'${lsbdistcodename}'.deb",
    subscribe  => File[ "/tmp/puppetlabs-release-'${lsbdistcodename}'.deb" ],
  }

  file{"/etc/apt/sources.list.d/puppetlabs.list":
  require => Exec["apt_update"],
  }

  exec { 'apt_update':
    path        => '/bin:/usr/bin:/sbin/:/usr/local/sbin:/usr/sbin:/sbin',
    command     => '/usr/bin/apt-get update',
    refreshonly => true,
  }
}
