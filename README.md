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

### Extra settings For Local Run
Modify the following configuration when you want to run the machine on your local machine.
```
vi <PROJECT_DIR>/project_directory

!!! Modify this to your user github username. This will be used to refer to the github
repository of your forked "video-freaks" project.

...
Modify here
github_user: Bariter

to your github user name
github_user: <GitHub User Name>
...
```

### AWS Provider
When you want to use aws-provider, you need to have the following additional configuration.

- Place the .pem file, which is a private key used for accessing the aws ec2, in the project directory.
- Create and place the .env file in the project directory: for example,
```
AWS_ACCESS_KEY_ID='AKI...'
AWS_SECRET_ACCESS_KEY='Bv2...'
```

## Run
### On Local Machine
```sh
$ vagrant up
```
### On AWS
```sh
$ vagrant up --provider=aws
```
