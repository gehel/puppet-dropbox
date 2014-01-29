# Puppet module: dropbox

This is a Puppet module for dropbox
It provides only package installation and file configuration.

Based on Example42 layouts by Alessandro Franceschi / Lab42

Official git repository: http://github.com/gehel/puppet-dropbox

Released under the terms of Apache 2 License.

This module requires the presence of Example42 Puppi module in your modulepath.


## USAGE - Basic management

* Install dropbox with default settings

        class { 'dropbox': }

* Install a specific version of dropbox package

        class { 'dropbox':
          version => '1.0.1',
        }

* Remove dropbox resources

        class { 'dropbox':
          absent => true
        }

* Enable auditing without without making changes on existing dropbox configuration *files*

        class { 'dropbox':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'dropbox':
          noops => true
        }


## USAGE - Overrides and Customizations
* Automatically include a custom subclass

        class { 'dropbox':
          my_class => 'example42::my_dropbox',
        }



## TESTING
[![Build Status](https://travis-ci.org/gehel/puppet-dropbox.png?branch=master)](https://travis-ci.org/gehel/puppet-dropbox)
