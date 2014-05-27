# == Class: redhat
#
# Manage RedHat systems.
#
# Meant to be applied to all systems where osfamily is RedHat.
#
class redhat (
  $root_bashrc_source = 'redhat/root_bashrc',
) {

  # redhat-lsb is needed for some facts that we will depend on. It should be
  # already installed by default in the kickstart.
  package { 'redhat-lsb':
    ensure => present,
  }

  file { 'root_bashrc':
    ensure => file,
    path   => "${::root_home}/.bashrc",
    source => "puppet:///modules/${root_bashrc_source}",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
}
