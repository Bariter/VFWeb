# To support box versioning and ssh-key insertion, set the min vagrant version.
Vagrant.require_version ">= 1.7.0"

ENV['AWS_PROFILE'] = 'vagrant-s3auth'
Dotenv.load

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
    web1.vm.network :private_network, ip: "192.168.33.11",
      virtualbox__intnet: true

    web1.vm.provision :ansible do |ansible|
      ansible.playbook = "site.yml"
      ansible.verbose = 'vvv'
    end
    web1.vm.provider :virtualbox do |v, override|

      web1.vm.hostname = "web1"

      web1.vm.network :forwarded_port, guest: 22, host: 2002, id: "ssh"
      web1.vm.network :forwarded_port, guest: 3000, host: 3000, id: "http2"
      web1.vm.network :forwarded_port, guest: 80, host: 8081, id: "http"

      # Actual VM name that will be created for virtualbox
      v.name = "vb-web1"

      v.memory = 1024
      v.cpus = 2

      v.gui = false
    end

    web1.vm.provider :aws do |aws, override|

      override.vm.box = "dummy"
      override.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

      aws.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
      aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
      aws.keypair_name = "video-freaks"
      aws.instance_type = "t2.micro"

      # Ubuntu Server 14.04 LTS(HVM), SSD Volume Type
      aws.ami = "ami-d05e75b8"

      aws.security_groups = ['video-freaks']
      aws.tags = {
        'Name' => 'Video_Freaks_Server',
        'Description' => 'Video freaks Server'
      }
      #aws.block_device_mapping = [
      #  {
      #    'DeviceName' => "/dev/sda1",
      #    'VirtualName' => "Volume name",
      #    'Ebs.VolumeSize' => 100,
      #    'Ebs.DeleteOnTermination' => true,
      #    'Ebs.VolumeType' => 'standard',
      #    #'Ebs.VolumeType' => 'io1',
      #    #'Ebs.Iops' => 1000
      #  }
      #]
      # -----
      #aws.subnet_id = 'Subnet ID'
      #aws.private_id_address = '192.168.0.33'
      #aws.elastic_ip = true

      override.ssh.username = "ubuntu"
      override.ssh.private_key_path = "video-freaks.pem"
    end
  end

  unless Vagrant.has_plugin?('vagrant-s3auth')
    # Attempt to install ourself. Bail out on failure so we don't get stuck in an
    # infinite loop.
    system('vagrant plugin install vagrant-s3auth') || exit!

    # Relaunch Vagrant so the plugin is detected. Exit with the same status code.
    exit system('vagrant' *ARGV)
  end

  unless Vagrant.has_plugin?('vagrant-aws')
    # Attempt to install ourself. Bail out on failure so we don't get stuck in an
    # infinite loop.
    system('vagrant plugin install vagrant-aws') || exit!

    # Relaunch Vagrant so the plugin is detected. Exit with the same status code.
    exit system('vagrant' *ARGV)
  end

  unless Vagrant.has_plugin?('dotenv')
    # Attempt to install ourself. Bail out on failure so we don't get stuck in an
    # infinite loop.
    system('vagrant plugin install dotenv') || exit!

    # Relaunch Vagrant so the plugin is detected. Exit with the same status code.
    exit system('vagrant' *ARGV)
  end
end
