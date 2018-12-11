puppet-module-redhat
===

Puppet module to manage RedHat systems.

Meant to be applied to all classes where `$::osfamily == RedHat`.

===

# Compatibility

This module has been tested to work on the following systems with the
latest Puppet v3, v3 with future parser, v4, v5 and v6.  See `.travis.yml`
for the exact matrix of supported Puppet and ruby versions.

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
