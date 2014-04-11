drupal-puppet
=============

An experiment in using Puppet to configure a Drupal server from scratch.

# Installation

Installation basically covers these steps (run everything as `sudo`):

1. [Install Puppet](http://docs.puppetlabs.com/guides/installation.html#debian-and-ubuntu)

# Standalone puppet

1. `wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb && dpkg -i puppetlabs-release-precise.deb && apt-get update` to use the Puppet Debian repository (fixes [an install bug](https://groups.google.com/forum/#!msg/puppet-users/W59B4KEx4e8/cQ7TbDllV3oJ))
1. `apt-get install puppet-common`
1. `puppet resource cron puppet-apply ensure=present user=root minute=30 command='/usr/bin/puppet apply $(puppet apply --configprint manifest)'` to install the standalone Puppet cron job
1. `puppet resource service` to check that Puppet is running correctly
1. `puppet apply --configprint manifest` to find out where your site manifest file is (usually `/etc/puppet/manifests/site.pp`) - in a fresh standalone install, this file will not exist

Now we need to decide on a way to handle modules, [Puppet does not automatically do this for us](http://blog.csanchez.org/2013/01/24/managing-puppet-modules-with-librarian-puppet/). Instead we'll use `puppet module` to directly add modules to our local Git repository.

1. `mv /etc/puppet /etc/puppet.disabled`
1. `git clone https://github.com/soundasleep/drupal-puppet /etc/puppet`

Now we can install everything! Yay!

1. `cd /etc/puppet`
1. `puppet apply manifests/site.pp`

However it doesn't actually install anything except an empty Apache. What's up next for configuration in Puppet:

1. PHP
1. PHP modules
1. Drupal
1. Drupal modules
1. Drupal `settings.php`

# Ideas...

* Put /etc/puppet under Git so we can keep track of modules. We can use git submodules to reference external modules, or use `puppet module` to install modules directly into our repository.
* Installing a new module: `puppet module search apache`