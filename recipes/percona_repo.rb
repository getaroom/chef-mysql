include_recipe 'apt'

case node['platform']
when "debian","ubuntu"

  apt_repository "percona" do
    keyserver "keys.gnupg.net"
    key "1C4CBDCDCD2EFD2A"
    deb_src true
    uri "http://repo.percona.com/apt"
    distribution node['lsb']['codename']
    components ["main"]
  end.run_action(:add)

  resources("file[/etc/apt/sources.list.d/percona-source.list]").run_action(:create)

  execute "compile time apt-get update" do
    command "apt-get update"
   end.run_action(:run)
end

