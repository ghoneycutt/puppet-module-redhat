puppet-module-redhat
===

[![Build Status](
https://api.travis-ci.org/ghoneycutt/puppet-module-redhat.png?branch=master)](https://travis-ci.org/ghoneycutt/puppet-module-redhat)

Puppet module to manage RedHat systems.

Meant to be applied to all classes where `$::osfamily == RedHat`.

===

# Compatibility

This module has been tested to work on the following systems with Puppet
versions 3 and 4 with Ruby versions 1.8.7, 1.9.3, 2.0.0, 2.1.0 and
2.3.1. For an exact matrix of Puppet and Ruby versions, please consult
.travis.yml.

  * EL 5
  * EL 6
  * EL 7

===

# Parameters

lsb_package
-----------
*string* Name of redhat-lsb package. EL7 is 'redhat-lsb-core' and previous versions are 'redhat-lsb'.

- *Default*: based on lsbmajdistrelease

root_bashrc_source
------------------
[module]/[filename] to serve for root's .bashrc.

- *Default*: 'redhat/root_bashrc'

root_bashrc_mode
----------------
String of four digit octal notation for mode of root's .bashrc.

- *Default*: '0644'

umask
-----
String of four digit octal notation for umask to be set in root's .bashrc. This is mutually exclusive with root_bashrc_source since it uses a template.

- *Default*: `undef`
