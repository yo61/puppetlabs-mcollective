# private class
class mcollective::server::config::securityprovider::aes_security {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { $mcollective::ssl_client_certs_dir_real:
    ensure  => 'directory',
    owner   => 'root',
    group   => '0',
    purge   => true,
    recurse => true,
    mode    => '0400',
    source  => $mcollective::ssl_client_certs,
  }

  mcollective::server::setting { 'plugin.ssl_client_cert_dir':
    value => $mcollective::ssl_client_certs_dir_real,
  }

  mcollective::server::setting { 'plugin.aes.server_public':
    value => "${mcollective::confdir}/server_public.pem",
  }

  mcollective::server::setting { 'plugin.aes.server_private':
    value => "${mcollective::confdir}/server_private.pem",
  }

  mcollective::server::setting { 'plugin.aes.enforce_ttl':
    value => $mcollective::aes_enforce_ttl,
  }
}
