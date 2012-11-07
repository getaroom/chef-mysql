remote_file "#{Chef::Config['file_cache_path']}/innotop-#{node['mysql']['innotop']['version']}.tar.gz" do
  source "http://innotop.googlecode.com/files/innotop-#{node['mysql']['innotop']['version']}.tar.gz"
  checksum node['mysql']['innotop']['checksum']
  backup false
  notifies :run, "execute[install innotop]", :immediately
end

execute "install innotop" do
  action :nothing
  command [
    "tar zxvf innotop-#{node['mysql']['innotop']['version']}.tar.gz",
    "cd innotop-#{node['mysql']['innotop']['version']}",
    "perl Makefile.PL",
    "make install",
  ].join(" && ")
  cwd Chef::Config['file_cache_path']
end
