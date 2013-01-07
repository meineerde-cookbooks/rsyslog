#
# Cookbook Name:: rsyslog
# Recipe:: server
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

node.run_state["rsyslog_server"] = true
include_recipe "rsyslog"

directory ::File.dirname(node['rsyslog']['server']['log_dir']) do
  owner node["rsyslog"]["user"]
  group node["rsyslog"]["group"]
  recursive true
  mode 0755
end

directory node['rsyslog']['server']['log_dir'] do
  owner node['rsyslog']['user']
  group node['rsyslog']['group']
  mode 0755
end

template "/etc/rsyslog.d/35-server-per-host.conf" do
  only_if{ node["rsyslog"]["server"]["per_host_logs"] }
  source "35-server-per-host.conf.erb"
  backup false
  variables(
    :log_dir => node['rsyslog']['server']['log_dir'],
    :per_host_dir => node['rsyslog']['server']['per_host_dir']
  )
  owner node["rsyslog"]["user"]
  group node["rsyslog"]["group"]
  mode 0644
  notifies :restart, "service[#{node['rsyslog']['service_name']}]"
end
