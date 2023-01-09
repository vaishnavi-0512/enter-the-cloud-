class nodejs (
  $nodejs_package = 'nodejs',
  $curl_package = 'curl',
  $curl_command = '/usr/bin/curl -sl https://deb.nodesource.com/setup_12.x | sudo -E bash -'
) {
  exec { 'curl-pre' :
    require => Package[$curl_package],
    command => $curl_command,
  }

  package { $curl_package:
    ensure => present,
  }
  package { $nodejs_package:
    require => Exec['curl-pre'],
    ensure => present,
  }
}
