# Class cis::linuxcontrols::c0003
#
# Ensure cryptographic verification of software packages using gpgcheck is
# enabled and the YUM configuration file permissions are restrictive.
#
class cis::linuxcontrols::c0003 {
  # not using this template any longer
  #file {'/etc/yum.conf':
  #  source  => 'puppet:///modules/cis/el6/etc/yum.conf',
  #  owner   => root,
  #  group   => root,
  #  mode    => '0640',
  #}
  file {'/etc/yum.conf':
    owner   => root,
    group   => root,
    mode    => '0640',
  }
  # puppetlabs/inifile
  ini_setting { 'improve security':
    ensure  => present,
    section => 'main',
    setting => 'gpgcheck',
    value   => '1',
  }
  # update the system on the 6th of the month (at random minutes after 1am)
  cron { 'system-update':
    command => 'yum clean all; yum -q -y update'
    user    => 'root',
    minute  => fqdn_rand(60),
    hour    => 1,
    day     => 6,
  }

    
}
