default['supervisor']['unix_http_server']['chmod'] = "0777"
default['supervisor']['daemon_options'] = "-c #{default['supervisor']['conffile']}"
