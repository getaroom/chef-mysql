include_recipe 'apt'

package "percona-xtrabackup"

directory "/mnt/xtrabackup" do
  owner "root"
  group "root"
  mode 0755
end

cron "removing previous xtrabackup" do
  hour "23"
  minute "1"
  command "rm -rf /mnt/xtrabackup/mysql && /usr/bin/innobackupex /mnt/xtrabackup/mysql --no-timestamp && /usr/bin/innobackupex --apply-log /mnt/xtrabackup/mysql && /usr/bin/innobackupex --apply-log /mnt/xtrabackup/mysql"
end
