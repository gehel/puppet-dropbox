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
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, dropbox main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $dropbox_source
#
# [*source_dir*]
#   If defined, the whole dropbox configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $dropbox_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $dropbox_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, dropbox main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $dropbox_template
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
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
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
    true  => 'absent',
    false => $dropbox::version,
  }

  $manage_file = $dropbox::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  $manage_audit = $dropbox::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $dropbox::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $dropbox::source ? {
    ''      => undef,
    default => $dropbox::source,
  }

  $manage_file_content = $dropbox::template ? {
    ''      => undef,
    default => template($dropbox::template),
  }

  if $dropbox::bool_manage_repo {
    require dropbox::repository
  }

  # ## Managed resources
  package { $dropbox::package:
    ensure => $dropbox::manage_package,
    noop   => $dropbox::bool_noops,
  }

  file { 'dropbox.conf':
    ensure  => $dropbox::manage_file,
    path    => $dropbox::config_file,
    mode    => $dropbox::config_file_mode,
    owner   => $dropbox::config_file_owner,
    group   => $dropbox::config_file_group,
    require => Package[$dropbox::package],
    source  => $dropbox::manage_file_source,
    content => $dropbox::manage_file_content,
    replace => $dropbox::manage_file_replace,
    audit   => $dropbox::manage_audit,
    noop    => $dropbox::bool_noops,
  }

  # The whole dropbox configuration directory can be recursively overriden
  if $dropbox::source_dir {
    file { 'dropbox.dir':
      ensure  => directory,
      path    => $dropbox::config_dir,
      require => Package[$dropbox::package],
      source  => $dropbox::source_dir,
      recurse => true,
      purge   => $dropbox::bool_source_dir_purge,
      force   => $dropbox::bool_source_dir_purge,
      replace => $dropbox::manage_file_replace,
      audit   => $dropbox::manage_audit,
      noop    => $dropbox::bool_noops,
    }
  }

  # ## Include custom class if $my_class is set
  if $dropbox::my_class {
    include $dropbox::my_class
  }

}
