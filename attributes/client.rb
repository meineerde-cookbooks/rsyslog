default["rsyslog"]["remote_logs"]      = true

default["rsyslog"]["client"]["protocol"]      = "tcp"
default["rsyslog"]["client"]["server_port"]   = 514
default["rsyslog"]["client"]["server_ip"]     = nil
default["rsyslog"]["client"]["server_name"]   = nil # required for tls protocol under Chef solo
default["rsyslog"]["client"]["server_search"] = "role:loghost"
default["rsyslog"]["client"]["forward_template"] = "RSYSLOG_TraditionalFileFormat"

