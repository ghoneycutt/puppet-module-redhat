# == Class: redhat
#
# Manage RedHat systems.
#
# Meant to be applied to all systems where osfamily is RedHat.
#
class redhat (
  $lsb_package        = 'USE_DEFAULTS',
  $root_bashrc_source = undef,
  $root_bashrc_mode   = '0644',
  $umask              = undef,
) {

  case $::lsbmajdistrelease {
    '5','6': {
      $lsb_package_default = 'redhat-lsb'
    }
    '7': {
      $lsb_package_default = 'redhat-lsb-core'
    }
    default: {
      fail("redhat module supports versions 5, 6 and 7. lsbmajdistrelease is <${::lsbmajdistrelease}>.")
    }
  }

  if $lsb_package == 'USE_DEFAULTS' {
    $lsb_package_real = $lsb_package_default
  } else {
    $lsb_package_real = $lsb_package
  }

  validate_string($lsb_package_real)

  validate_re($root_bashrc_mode, '^[0-7]{4}$',
    "redhat::root_bashrc_mode is <${root_bashrc_mode}> and must be a valid four digit mode in octal notation.")

  if $umask != undef {
    validate_re($umask, '^[0-7]{4}$',
      "redhat::umask is <${umask}> and must be a valid four digit mode in octal notation.")
  }

  # redhat-lsb is needed for some facts that we will depend on. It should be
  # already installed by default in the kickstart.
  package { 'redhat-lsb':
    ensure => present,
    name   => $lsb_package_real,
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
