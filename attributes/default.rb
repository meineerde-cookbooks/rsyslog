#
# Cookbook Name:: rsyslog
# Attributes:: rsyslog
#
# Copyright 2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default["rsyslog"]["max_message_size"] = "2k"
default["rsyslog"]["remote_logs"] = true

# The most likely platform-specific attributes
default["rsyslog"]["service_name"]     = "rsyslog"
default["rsyslog"]["user"] = "root"
default["rsyslog"]["group"] = "adm"
default["rsyslog"]["priv_seperation"] = false
default["rsyslog"]["defaults_file"]   = "/etc/default/rsyslog"

default['rsyslog']['rotate_command'] = "invoke-rc.d rsyslog reload"

case node["platform"]
when "ubuntu"
  # syslog user introduced with natty package
  if node['platform_version'].to_f > 10.10 then
    default["rsyslog"]["user"] = "syslog"
    default["rsyslog"]["group"] = "adm"
    default["rsyslog"]["priv_seperation"] = true
  end
when "redhat"
  default["rsyslog"]["defaults_file"] = "/etc/sysconfig/rsyslog"
when "arch"
  default["rsyslog"]["service_name"] = "rsyslogd"
when 'debian'
  if node['platform_version'].to_f >= 7 then
    default['rsyslog']['rotate_command'] = "invoke-rc.d rsyslog rotate"
  end
end
