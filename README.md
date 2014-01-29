# Puppet module: puppet-dropbox

This is a Puppet module for puppet-dropbox
It provides only package installation and file configuration.

Based on Example42 layouts by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-puppet-dropbox

Released under the terms of Apache 2 License.

This module requires the presence of Example42 Puppi module in your modulepath.


## USAGE - Basic management

* Install puppet-dropbox with default settings

        class { 'puppet-dropbox': }

* Install a specific version of puppet-dropbox package

        class { 'puppet-dropbox':
          version => '1.0.1',
        }

* Remove puppet-dropbox resources

        class { 'puppet-dropbox':
          absent => true
        }

* Enable auditing without without making changes on existing puppet-dropbox configuration *files*

        class { 'puppet-dropbox':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'puppet-dropbox':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'puppet-dropbox':
          source => [ "puppet:///modules/example42/puppet-dropbox/puppet-dropbox.conf-${hostname}" , "puppet:///modules/example42/puppet-dropbox/puppet-dropbox.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'puppet-dropbox':
          source_dir       => 'puppet:///modules/example42/puppet-dropbox/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'puppet-dropbox':
          template => 'example42/puppet-dropbox/puppet-dropbox.conf.erb',
        }

* Automatically include a custom subclass

        class { 'puppet-dropbox':
          my_class => 'example42::my_puppet-dropbox',
        }



## TESTING
[![Build Status](https://travis-ci.org/example42/puppet-puppet-dropbox.png?branch=master)](https://travis-ci.org/example42/puppet-puppet-dropbox)
