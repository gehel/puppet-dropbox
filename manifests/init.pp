# = Class: dropbox
#
# This is the main dropbox class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, dropbox class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $dropbox_myclass
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $dropbox_options
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $dropbox_absent
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $dropbox_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: false
#
# Default class params - As defined in dropbox::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of dropbox package
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include dropbox"
# - Call dropbox as a parametrized class
#
# See README for details.
#
class dropbox (
  $my_class    = params_lookup('my_class'),
  $version     = params_lookup('version'),
  $absent      = params_lookup('absent'),
  $audit_only  = params_lookup('audit_only', 'global'),
  $noops       = params_lookup('noops'),
  $package     = params_lookup('package'),
  $manage_repo = params_lookup('manage_repo'),) inherits dropbox::params {
  $bool_absent = any2bool($absent)
  $bool_audit_only = any2bool($audit_only)
  $bool_noops = any2bool($noops)

  $bool_manage_repo = any2bool($dropbox::params::manage_repo) and !$bool_noops

  # ## Definition of some variables used in the module
  $manage_package = $dropbox::bool_absent ? {
    true    => 'absent',
    default => $dropbox::version,
  }

  $manage_file = $dropbox::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  $manage_audit = $dropbox::bool_audit_only ? {
    true    => 'all',
    default => undef,
  }

  $manage_file_replace = $dropbox::bool_audit_only ? {
    true    => false,
    default => true,
  }

  if $dropbox::bool_manage_repo {
    require dropbox::repository
  }

  # ## Managed resources
  package { $dropbox::package:
    ensure => $dropbox::manage_package,
    noop   => $dropbox::bool_noops,
  }

  # ## Include custom class if $my_class is set
  if $dropbox::my_class {
    include $dropbox::my_class
  }

}
