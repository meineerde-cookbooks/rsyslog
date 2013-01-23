#
# Cookbook Name:: rsyslog
# Recipe:: client
#
# Copyright 2009-2011, Opscode, Inc.
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

include_recipe "rsyslog"

if Chef::Config[:solo] && node['rsyslog']['client']['server_ip'].nil?
  Chef::Log.fatal("Chef Solo does not support search, therefore it is a requirement of the rsyslog::client recipe that the attribute node['rsyslog']['client']['server_ip'] is set when using Chef Solo.")
elsif Chef::Config[:solo] && node['rsyslog']['client']['protocol'] == "tls" && node['rsyslog']['client']['server_name'].nil?
  Chef::Log.fatal("Chef Solo does not support search, therefore it is a requirement of the rsyslog::client recipe that the attribute node['rsyslog']['client']['server_name'] is set when using Chef Solo.")
else
  server_ip = node['rsyslog']['client']['server_ip'] ||
                search(:node, node['rsyslog']['client']['server_search']).first['ipaddress'] rescue nil

  if server_ip.nil?
    raise "The rsyslog::client recipe was unable to determine the remote syslog server. Checked both the node['rsyslog']['client']['server_ip'] attribute and search()"
  end


  if node['rsyslog']['client']['protocol'] == "tls"
    server_name = node['rsyslog']['client']['server_name'] ||
                    search(:node, node['rsyslog']['client']['server_search']).first['fqdn'] rescue nil

    if server_name.nil?
      raise "The rsyslog::client recipe was unable to determine the remote syslog server. Checked both the node['rsyslog']['client']['server_name'] attribute and search()"
    end
  end

  template "/etc/rsyslog.d/49-remote.conf" do
    only_if { node['rsyslog']['remote_logs'] }
    source "49-remote.conf.erb"
    backup false
    variables(
      :server_ip => server_ip,
      :server_name => server_name
    )
    owner node["rsyslog"]["user"]
    group node["rsyslog"]["group"]
    mode 0644
    notifies :restart, "service[#{node['rsyslog']['service_name']}]"
  end
end
