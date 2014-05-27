# == Class: redhat
#
# Manage RedHat systems.
#
# Meant to be applied to all systems where osfamily is RedHat.
#
class redhat (
  $root_bashrc_source = undef,
  $root_bashrc_mode   = '0644',
) {

  validate_re($root_bashrc_mode, '^[0-7]{4}$',
    "redhat::root_bashrc_mode is <${root_bashrc_mode}> and must be a valid four digit mode in octal notation.")

  # redhat-lsb is needed for some facts that we will depend on. It should be
  # already installed by default in the kickstart.
  package { 'redhat-lsb':
    ensure => present,
  }

  if $root_bashrc_source == undef {
    $root_bashrc_content = template('redhat/root_bashrc.erb')
    $root_bashrc_source_real = undef
  } else {
    $root_bashrc_content = undef
    $root_bashrc_source_real = "puppet:///modules/${root_bashrc_source}"
  }

  file { 'root_bashrc':
    ensure  => file,
    path    => "${::root_home}/.bashrc",
    source  => $root_bashrc_source_real,
    content => $root_bashrc_content,
    owner   => 'root',
    group   => 'root',
    mode    => $root_bashrc_mode,
  }
}
