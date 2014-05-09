# == Class: redhat
#
# Manage RedHat systems.
#
# Meant to be applied to all systems where osfamily is redhat.
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

  # GH: TODO - Refactor this and ghoneycutt/inittab into an init module with a
  # define that takes source or content and place a file in /etc/init/
  #
  # EL6 uses Upstart instead of inittab, which normally manages ttyS1 for
  # console users.
  if $::lsbmajdistrelease == '6' {
    file { 'ttys1_conf':
      ensure => file,
      path   => '/etc/init/ttyS1.conf',
      source => 'puppet:///modules/redhat/ttyS1.conf',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }

    # Ensure that the service is running.
    service { 'ttyS1':
      ensure     => running,
      hasstatus  => false,
      hasrestart => false,
      start      => '/sbin/initctl start ttyS1',
      stop       => '/sbin/initctl stop ttyS1',
      status     => '/sbin/initctl status ttyS1 | grep ^"ttyS1 start/running" 1>/dev/null 2>&1',
      require    => File['ttys1_conf'],
    }
  }
}
