include cisco_ios
include resource_api::server

service { 'firewalld.service':
  ensure => 'stopped',
  enable => 'false',
}

service { 'pe-puppetserver':
  ensure     => 'running',
  enable     => true,
  hasrestart => true,
  restart    => 'service pe-puppetserver reload',
}

file { '/root/.bash_profile':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  content => file(inline_template("<%= File.expand_path(File.dirname(__FILE__)) + '/bash_profile' %>")),
}

# DevNet Sandbox (5/24/2018) has invalid known_hosts key
file { '/root/.ssh/known_hosts':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  content => '',
}
