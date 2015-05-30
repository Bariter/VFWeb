# VFWeb
This repo contains the necessary configuration files to deploy our web-servers.

## Note
- This Vagrantfile will install `vagrant-s3auth` plugin in order to use the box    
  stored on the private aws s3 storage if your system doesn't have the plugin installed.

## Configuration
### AWS Credentials
This Vagrantfile uses [vagrant-s3auth](https://github.com/WhoopInc/vagrant-s3auth).
The step-by-step directions are the following.

- Create `~/.aws/credentials` and put down your credentials as the profile, "vagrant-s3auth".    
For example,

```
...

[vagrant-s3auth]
aws_access_key_id = AKI...
aws_secret_access_key = ...
```

Ask for your account manager about your credentials.

That's pretty much about it. You can now start using the box by `vagrant up`.
For the first time, it will take some additional time for this command to download the box.
