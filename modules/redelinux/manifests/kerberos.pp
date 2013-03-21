class redelinux::kerberos
{
    include redelinux::params
    
    # Kerberos
    $kerberos = ["krb5-user", "libpam-krb5"]

    package { $kerberos:
        ensure => present,
    }

    util::config_file { 'krb5.conf':
        path    => '/etc/krb5.conf',
        require => Package[$kerberos],
    }
    
    $group = $redelinux::params::kerberos_admin_group
    $realm = $redelinux::params::kerberos_realm
    
    $users_line = chomp(generate('/usr/bin/getent', 'group', $group))
    $users_list = regsubst($users_line, '^.+:', '')
    $principals = suffix(split($users_list, ','), "/admin@${realm}")

    if !empty($principals) {  
        k5login { 'redelinux':
            ensure     => present,
            path       => '/root/.k5login',
            principals => $principals
        }
    }
}    
