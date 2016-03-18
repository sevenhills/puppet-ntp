## To Run
1. Copy this module and its dependencies to `targethost:/etc/puppet/modules/`     
Ensure that the directory names match the class names for each module.
2. Ensure that `/etc/puppet/hiera.yaml` exists, and `:datadir:` points to
`/var/lib/hiera/` (or its value is blank, which defaults to this same path).
3. Using the sample in `samples/hieradata/defaults.yaml` as a reference,
ensure `/var/lib/hiera/defaults.yaml` exists and contains the proper hiera data.
4. Run puppet apply: `sudo puppet apply -v -e "include ntp"`


## Class: ntp

This module installs and configures ntp.

### Parameters:

```
=== REQUIRED Parameters
$version::    Target version of ntp to install. Ensure this version
              is hosted on your target machine's yum repository
$servers::    List of ntp servers
```

See params.pp for complete list of optional parameters.

### Requires:

+ CentOS6.x     
+ ntp package in repo     
+ Puppet Modules
    - stdlib

### Hiera:
   link /etc/hiera.yaml to /etc/puppet/modules/site/ext/hiera.yaml
   hiera data dir set to /etc/puppet/modules/site/data/defaults.yaml

### Sample Usage:
    # One way to declare the class
    class {"::ntp": }
    # The first two colons indicate top-scope, meaning ntp should be a 
    # module that lives in /etc/puppet/modules/


###
Testing GIT operations.
