case node['platform']
when "debian","ubuntu"
  include_recipe 'apt'

  apt_repository "percona" do
    key "percona.key"
    trusted true
    deb_src true
    uri "http://repo.percona.com/apt"
    distribution node['lsb']['codename']
    components ["main"]
    cache_rebuild true
  end.run_action(:add)

  resources("file[/etc/apt/sources.list.d/percona.list]").run_action(:create)
end
