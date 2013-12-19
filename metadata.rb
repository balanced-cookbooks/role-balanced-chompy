name             'role-balanced-chompy'
maintainer       'Balanced'
maintainer_email 'dev@balancedpayments.com'
license          'MIT'
description      'Installs/Configures role-balanced-chompy'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'

depends          'balanced-monit', '~> 0.1.0'
depends          'balanced-postgres', '~> 0.1.0'
depends          'balanced-chompy', '~> 0.1.0'
