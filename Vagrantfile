# To support box versioning and ssh-key insertion, set the min vagrant version.
Vagrant.require_version ">= 1.7.0"

ENV['AWS_PROFILE'] = 'vagrant-s3auth'

Vagrant.configure(2) do |config|
  # Non-provider specific configuration.

  # Box name to use for provisioning
  config.vm.box = "bariter/web"

  config.vm.box_check_update = true

  config.vm.box_url = "https://s3.amazonaws.com/bariter-virtualbox/private_image_vb_web.json"

  config.vm.post_up_message = "Let's freak out!"

  config.vm.box_download_checksum_type = "sha1"
  config.vm.box_download_checksum = "00ed12f134db4ab6f76fef5f2c11546e432df2a7"

  # Set false to insert new ssh key. Use default insecure private key, instead.
  config.ssh.insert_key = false

  ################################
  # web-servers configurations
  ################################
  config.vm.define :web1 do |web1|
    web1.vm.hostname = "web1"

    web1.vm.network :private_network, ip: "192.168.33.11",
        virtualbox__intnet: true
    web1.vm.network :forwarded_port, guest: 22, host: 2002, id: "ssh"

    web1.vm.provider :virtualbox do |v, override|

      # Actual VM name that will be created for virtualbox
      v.name = "vb-web1"

      v.gui = false
    end
    web1.vm.provision :ansible, :playbook => "site.yml"
  end

  unless Vagrant.has_plugin?('vagrant-s3auth')
    # Attempt to install ourself. Bail out on failure so we don't get stuck in an
    # infinite loop.
    system('vagrant plugin install vagrant-s3auth') || exit!

    # Relaunch Vagrant so the plugin is detected. Exit with the same status code.
    exit system('vagrant' *ARGV)
  end
end
