puppet-module-redhat
===

Puppet module to manage RedHat systems.

Meant to be applied to all classes where `$::osfamily == redhat`.

# Compatibility #

  * EL 5
  * EL 6

### Parameters: ###
root_bashrc_source
------------------
[module]/[filename] to serve for root's .bashrc

- *Default*: 'redhat/root_bashrc'
