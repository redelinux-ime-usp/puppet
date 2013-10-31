# This resource manages a file, usually a configuration file, by automatically
# selecting sources according to pre-defined rules:
#
# 1) Sources live on the caller file module's files folder.
# 2) Sources have the form <sources_path>/<file_path>[-selector]
# 3) Selectors, in order of use, from first to last:
#    - $::fqdn
#    - $::hostname
#    - contents of $redelinux::params::host_groups, in alphabetical order.
#    - '' (the preceding dash is ommited)
# 4) If none of the previous sources are available, paths listed in the
#    'extra_sources' param, if any, will be used (in passed order).
#
# All the other parameters are equivalent to their 'file' counterparts,
# but with sane defaults allowing them to be ommited for configuration files.
# The only special case is 'content', which disables the source lookup logic.

define cfgutil::config_file(
    $path          = $title,
    $ensure        = file,
    $content       = '$undef$',
    $source        = undef,
    $replace       = undef,
    $mode          = undef,
    $recurse       = undef,
    $extra_sources = undef,
)
{
    if $ensure == 'absent' {
        file { $title:
            ensure => absent,
            path   => $path,
        }
    } else {
		File {
		    ensure  => $ensure,
		    owner   => 'root',
		    group   => 'root',
		    mode    => $mode ? {
				undef   => '0644',
				default => $mode,
			},
		    path    => $path,
		    replace => $replace,
		    recurse => $recurse,
	    }

		# Work around the fact that even passing content as undef sometimes
		# causes the 'You cannot specify more than one of content, source, target'
		# error.
		# For some stupid reason, undef == '', work around it as well.

		if $content != '$undef$' {
		    if $source != undef {
				fail("You must specify one of: content, source")
		    }

		    file { $title: 
				content => $content,
		    }
		} else {
		    $selectors = flatten([$::fqdn, $::hostname, sort($redelinux::params::host_groups)])
		    $selector_sources = prefix($selectors, "puppet:///modules/${caller_module_name}/${path}$$")
		     
		    if $extra_sources != undef {
				# we have two cases: extra_sources is either an array or a string
				# either way we encapsulate it in another array and let flatten
				# fix everything
				$extra_sources_real = [$extra_sources]
		    } else {
				$extra_sources_real = []
		    }
	            
            $path_clean = regsubst($path, '/+$', '')
		    $sources = flatten([$selector_sources,
							   "puppet:///modules/${caller_module_name}/${path_clean}",
							    $extra_sources_real])

		    file { $title:
				source => $sources
		    }
		}
    }
}