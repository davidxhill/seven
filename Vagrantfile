# -*- mode: ruby -*-
# vi: set ft=ruby :

#server configs
server_ip = "10.22.2.2"
server_mem = "1024"
document_root = "/vagrant"
public_root = "/vagrant/public"

open_livereload = true

#db configs - currently only supports mysql.
db_type = "mysql"
db_passwd = "root"
db_create = true
db_name = "seven"
db_permission = true #set permissions to allow standard connections through SequelPro

#packages config
include_vim_prefs = false

include_node = true
global_node_packages = [
    "grunt-cli",
    "grunt-init",
    "jamjs",
    "testem"
]

include_ruby = true
rvm_version = "stable"
gem_packages = [
    "sass"
]

include_grunt = true

#php package config
include_composer = true
global_composer_packages = [
    "phpunit/phpunit:4.0.*"
]

include_php_myadmin = true

#laravel package config
include_laravel = true
l4_set_env_vars = true

include_seven_bootstrapper = true

#vagrant config
Vagrant.configure("2") do |config|

    #server set to Ubuntu 12.04
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    #setting static ip
    config.vm.network "private_network", ip: server_ip

    #open port for livereload
    if open_livereload === true
        config.vm.network :forwarded_port, guest: 35729, host: 35729
    end

    #set hostname
    config.vm.hostname = "dev"

    #config synced folder
    config.vm.synced_folder "./", "/vagrant", id: "vagrant-root", :owner => "vagrant", :group => "www-data"
    
    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", server_mem]
    end

    #base
    config.vm.provision "shell", path: "scripts/base.sh" 

    #php
    config.vm.provision "shell", path: "scripts/php.sh" 

    #apache
    config.vm.provision "shell", path: "scripts/apache.sh", args: "#{server_ip} #{public_root}"

    if db_type === "mysql"
       config.vm.provision "shell", path: "scripts/mysql.sh", args: "#{db_passwd} #{db_permission} #{db_create} #{db_name}"
    end

    if include_php_myadmin === true
       config.vm.provision "shell", path: "scripts/phpmyadmin.sh"
    end

    if include_vim_prefs === true
       config.vm.provision "shell", path: "scripts/vim.sh"
    end

    if include_ruby === true
       config.vm.provision "shell", path: "scripts/ruby.sh", args: "#{rvm_version} " + gem_packages.join(" ")
    end

    if include_node === true
       config.vm.provision "shell", path: "scripts/node.sh", args: global_node_packages.join(" ")
    end

    if include_composer === true
       config.vm.provision "shell", path: "scripts/composer.sh", args: global_composer_packages.join(" ")
    end
    
    if include_seven_bootstrapper === true
       config.vm.provision "shell", path: "scripts/bootstrapper.sh"
    end

end

