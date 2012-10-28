case node['platform']
when "debian","ubuntu"
  include_recipe 'apt'

  apt_repository "percona" do
    key "percona.key"
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
