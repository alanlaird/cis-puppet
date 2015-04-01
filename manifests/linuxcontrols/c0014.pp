# Class cis::linuxcontrols::c0015
#
# Disable core dumps.
#

class cis::linuxcontrols::c0014 {
  #file {'/etc/security/limits.conf':
  #  source  => 'puppet:///modules/cis/el6/etc/security/limits.conf',
  #  owner   => root,
  #  group   => root,
  #  mode    => '0640',
  #}
  augeas { "limits_conf/*/hard/core":
    $domain   = '*',
    $type     = 'hard',
    $item     = 'core',
    $value    = 0,
    $context  = '/files/etc/security/limits.conf',
    $path_list  = "domain[.=\"$domain\"][./type=\"$type\" and ./item=\"$item\"]"
    $path_exact = "domain[.=\"$domain\"][./type=\"$type\" and ./item=\"$item\" and ./value=\"$value\"]"
    changes => [
      # remove all matching to the $domain, $type, $item, for any $value
      "rm $path_list", 
      # insert new node at the end of tree
      "set domain[last()+1] $domain",
      # assign values to the new node
      "set domain[last()]/type $type",
      "set domain[last()]/item $item",
      "set domain[last()]/value $value",
    ],
  }
}
