Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.box_check_update = true
  config.vm.network "forwarded_port", guest: 8080, host: 9080, id: "Jenkins"
  config.vm.network "forwarded_port", guest: 8081, host: 9081, id: "NexusUI"
  config.vm.network "forwarded_port", guest: 8082, host: 9082, id: "PrivateRegistry"
  config.vm.network "forwarded_port", guest: 9000, host: 9083, id: "Sonarqube"
  config.vm.network "forwarded_port", guest: 50000, host: 9084, id: "JenkinsAgentsPort"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.name = "ATLatamVM"
    vb.cpus = 2
    vb.memory = "8096"
  end
  config.vm.provision "file", source: "docker-compose.yaml", destination: "$HOME/stack/docker-compose.yaml"
  config.vm.provision "file", source: "provisioner.sh", destination: "/tmp/provisioner.sh"
  config.vm.provision "shell", inline: <<-SHELL
    chmod +x /tmp/provisioner.sh
    /tmp/provisioner.sh /home/vagrant/stack/docker-compose.yaml
    cd /home/vagrant/stack/
    docker-compose exec -d -u root jenkins chown jenkins /var/run/docker.sock
  SHELL
end
