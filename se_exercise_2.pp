package { 'vim-enhanced':
  ensure => installed,
  allow_virtual => 'true'
}


package { 'curl':
  require => Package['vim-enhanced'], 
  ensure => installed,
}


package { 'git':
  require => Package['curl'], 
  ensure => installed,
}

account {

  user { 'monitor':
    ensure      => present,
    home        => '/home/monitor',
    shell       => '/bin/bash',
    managehome  => true,
    }

}

file { '/home/monitor/scripts':
    ensure => 'directory',
}

exec {'retrieve_script':
  command => "/usr/bin/wget -q https://raw.githubusercontent.com/zstarter/scripts/master/memory_check.sh -O /home/monitor/scripts/memory_check.sh",
  creates => "/home/monitor/scripts/memory_check.sh",
}

file {'/home/monitor/scripts/memory_check.sh':
  ensure => present,
  mode => 0755,
  require => Exec["retrieve_script"],
}

file { '/home/monitor/src':
    ensure => 'directory',
}

file { '/home/monitor/scripts/my_memory_check.sh':
    ensure => 'link',
    target => '/home/monitor/scripts/memory_check.sh',
}

cron { 'mon':
  command => 'sh /home/monitor/scripts/memory_check.sh',
  user    => 'monitor',
  minute  => '*/10',
}