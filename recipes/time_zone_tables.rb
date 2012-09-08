#
# Cookbook Name:: mysql
# Recipe:: time_zone_tables
#
# Author:: Chris Griego (<cgriego@getaroom.com>)
#
# Copyright 2012, getaroom
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

include_recipe "mysql::ruby"

execute "populate MySQL Time Zone Tables" do
  command %{mysql_tzinfo_to_sql /usr/share/zoneinfo | "#{node['mysql']['mysql_bin']}" mysql -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }"#{node['mysql']['server_root_password']}"}

  not_if do
    Gem.clear_paths
    require 'mysql'
    mysql = Mysql.new("localhost", "root", node['mysql']['server_root_password'], "mysql")

    begin
      mysql.query("select count(*) from time_zone").fetch_row.first.to_i > 0
    ensure
      mysql.close
    end
  end
end
