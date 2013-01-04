default["rsyslog"]["server"]["log_dir"]       = "/srv/rsyslog"
default["rsyslog"]["server"]["protocols"]     = ["tcp", "udp"]
default["rsyslog"]["server"]["tcp_port"]      = 514
default["rsyslog"]["server"]["udp_port"]      = 514
default["rsyslog"]["server"]["tls_port"]      = 514

default["rsyslog"]["server"]["per_host_dir"]  = "%HOSTNAME%/%$YEAR%/%$MONTH%/%$DAY%"
