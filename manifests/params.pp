# Class: dropbox::params
#
# This class defines default parameters used by the main module class dropbox
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to dropbox class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class dropbox::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'dropbox',
  }

  $manage_repo = true

  # General Settings
  $my_class = ''
  $version = 'present'
  $absent = false
  $audit_only = false
  $noops = false

}
