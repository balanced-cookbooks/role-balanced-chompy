include_recipe 'balanced-monit'

include_recipe 'balanced-rabbitmq::local'

include_recipe 'balanced-postgres::client'

include_recipe 'role-base'
include_recipe 'balanced-chompy'
include_recipe 'balanced-chompy::worker'
