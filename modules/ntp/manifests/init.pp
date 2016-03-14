# = Class: ntp
#
# This module installs and configures ntp.
#
# == Parameters:
#
# See params.pp for a complete description of all variables and default values
#
# === REQUIRED Parameters
# $version::    Target version of ntp to install. Ensure this version
#               is hosted on your target machine's yum repository.
#
# == Requires:
#
# CentOS6.x
# ntp package
# Puppet Modules
#   - stdlib
#
# == Sample Usage:
#
#   Ensure hiera data is set (example in samples dir).
#
#   To run:
#   sudo puppet apply -v -e "include ntp"
#
#
class ntp (
    $absent                        = $ntp::params::absent,
    $version                       = $ntp::params::version,
    $config_file_mode              = $ntp::params::config_file_mode,
    $config_file_owner             = $ntp::params::config_file_owner,
    $config_file_group             = $ntp::params::config_file_group,
    $servers                       = $ntp::params::servers,

    # Import default parameters used in this module.
    # Convention: http://docs.puppetlabs.com/puppet/3/reference/lang_classes.html#inheritance
    ) inherits ntp::params {

    # include stdlib

    if $absent {
        $ensure_pkg     = absent
        $ensure_svc     = stopped
        $ensure_file    = absent
    }else {
        $ensure_pkg     = $version
        $ensure_svc     = running
        $ensure_file    = file
    }

    $service = $::operatingsystem ? {
       /(?i:Debian|Ubuntu|Mint|Solaris)/ => 'ntp',
       /(?i:SLES|OpenSuSE)/              => 'ntp',
       default                           => 'ntpd',
    }

    package { 'ntp':
        ensure  => $ensure_pkg,
    }

    file { '/etc/ntp':
        ensure => 'directory',
        require => Package['ntp'],
        owner   => $config_file_owner,
        group   => $config_file_group,
    }

    file { "ntp.conf":
        ensure  => $ntp::ensure_file,
        path    => "/etc/ntp/ntp.conf",
        mode    => $config_file_mode,
        owner   => $config_file_owner,
        group   => $config_file_group,
        content => template("ntp/ntp.conf.erb"),
        notify  => Service[$service],
        require => File['/etc/ntp'],
    }

    service { "$service":
        ensure      => $ntp::ensure_svc,
        enable      => !$ntp::absent,
        hasrestart  => true,
        hasstatus   => true,
        require     => File["ntp.conf"],
    }

}
