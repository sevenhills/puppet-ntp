# = Class: ntp::params
#
# Sets internal variables and defaults for the ntp module, as well as
# defaults for the ntp.conf application config.
#
# For more general information about this ntp puppet module, see init.pp
# or README.md. For default values, see the class definition below.
#
# == Parameters:
#
# === REQUIRED Parameters
# $version::    Target version of ntp to install. Ensure this version
#               is hosted on your target machine's yum repository.
#
# === OPTIONAL Parameters
# $absent::     If true, ntp and associated config files will be removed
#               from the target system. Defaults to false.
# $config_file_mode::
# $config_file_owner::
# $config_file_group::
#               Ownership and permissions for ntp.conf.
#   listen_address
#               The listening address, eg. 0.0.0.0 for all interfaces
#   port
#               The listening port. Defaults to 123.
#

class ntp::params  {

    $version                    = latest
    $absent                     = false
    $config_file_mode           = 644
    $config_file_owner          = root
    $config_file_group          = root
    $servers                = [ '0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org', '3.pool.ntp.org', '4.pool.ntp.org' ]
}

