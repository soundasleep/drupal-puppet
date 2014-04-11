class { 'apache': 
	default_mods => false,
	default_confd_files => false,
}

apache::vhost { 'localhost':
	port => '80',
	docroot => '/var/www/drupal',
}

notify { 'finished':
  message => 'Puppet finished.',
}

