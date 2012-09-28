include_recipe 'apt'

case node['platform']
when "debian","ubuntu"

  file "/var/lib/apt/periodic/update-success-stamp" do
    action :delete
  end

  apt_repository "percona" do
    keyserver "keys.gnupg.net"
    key "1C4CBDCDCD2EFD2A"
    deb_src true
    uri "http://repo.percona.com/apt"
    distribution node['lsb']['codename']
    components ["main"]
  end.run_action(:add).run_action(:create)

  execute "compile time apt-get update" do
    command "apt-get update"
   end.run_action(:run)
end


