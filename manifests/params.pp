# Class: puppet-dropbox::params
#
# This class defines default parameters used by the main module class puppet-dropbox
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to puppet-dropbox class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class puppet-dropbox::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'puppet-dropbox',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/puppet-dropbox',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/puppet-dropbox/puppet-dropbox.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $version = 'present'
  $absent = false
  $audit_only = false
  $noops = false

}
