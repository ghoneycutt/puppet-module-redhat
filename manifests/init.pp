# == Class: redhat
#
# Manage RedHat systems.
#
# Meant to be applied to all systems where osfamily is RedHat.
#
class redhat (
  $root_bashrc_source = 'redhat/root_bashrc',
  $root_bashrc_mode   = '0644',
) {

  validate_re($root_bashrc_mode, '^[0-7]{4}$',
    "redhat::root_bashrc_mode is <${root_bashrc_mode}> and must be a valid four digit mode in octal notation.")

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
    mode   => $root_bashrc_mode,
  }
}
